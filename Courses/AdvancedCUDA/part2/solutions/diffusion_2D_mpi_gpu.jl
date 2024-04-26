# # 2D linear diffusion Julia MPI solver
using Plots, Printf, MAT
import MPI
using CUDA

# enable plotting by default
if !@isdefined do_save; do_save = true end

# MPI functions
@views function update_halo(A, neighbors_x, neighbors_y, comm)
    # Send to / receive from neighbor 1 in dimension x ("left neighbor")
    if neighbors_x[1] != MPI.PROC_NULL
        sendbuf = zeros(size(A,2))
        copyto!(sendbuf, A[2,:])
        recvbuf = zeros(size(A[1,:]))
        MPI.Send(sendbuf,  neighbors_x[1], 0, comm)
        MPI.Recv!(recvbuf, neighbors_x[1], 1, comm)
        copyto!(A[1,:], recvbuf)
    end
    # Send to / receive from neighbor 2 in dimension x("right neighbor")
    if neighbors_x[2] != MPI.PROC_NULL
        sendbuf = zeros(size(A,2))
        copyto!(sendbuf, A[end-1,:])
        recvbuf = zeros(size(A[end,:]))
        MPI.Send(sendbuf,  neighbors_x[2], 1, comm)
        MPI.Recv!(recvbuf, neighbors_x[2], 0, comm)
        copyto!(A[end,:], recvbuf)
    end
    # Send to / receive from neighbor 1 in dimension y ("bottom neighbor")
    if neighbors_y[1] != MPI.PROC_NULL
        sendbuf = zeros(size(A,1))
        copyto!(sendbuf, A[:,2])
        recvbuf = zeros(size(A[:,1]))
        MPI.Send(sendbuf,  neighbors_y[1], 2, comm)
        MPI.Recv!(recvbuf, neighbors_y[1], 3, comm)
        copyto!(A[:,1], recvbuf)
    end
    # Send to / receive from neighbor 2 in dimension y ("top neighbor")
    if neighbors_y[2] != MPI.PROC_NULL
        sendbuf = zeros(size(A,1))
        copyto!(sendbuf, A[:,end-1])
        recvbuf = zeros(size(A[:,end]))
        MPI.Send(sendbuf,  neighbors_y[2], 3, comm)
        MPI.Recv!(recvbuf, neighbors_y[2], 2, comm)
        copyto!(A[:,end], recvbuf)
    end   
    return
end

@views function diffusion_2D_mpi(; do_save=false)
    # MPI
    MPI.Init()
    dims        = [0,0]
    comm        = MPI.COMM_WORLD
    nprocs      = MPI.Comm_size(comm)
    MPI.Dims_create!(nprocs, dims)
    comm_cart   = MPI.Cart_create(comm, dims, [0,0], 1)
    me          = MPI.Comm_rank(comm_cart)
    coords      = MPI.Cart_coords(comm_cart)
    neighbors_x = MPI.Cart_shift(comm_cart, 0, 1)
    neighbors_y = MPI.Cart_shift(comm_cart, 1, 1)
    if (me==0) println("nprocs=$(nprocs), dims[1]=$(dims[1]), dims[2]=$(dims[2])") end
    # Physics
    lx, ly     = 10.0, 10.0
    λ          = 1.0
    nt         = 100
    # Numerics
    nx, ny     = 32, 32                             # local number of grid points
    nx_g, ny_g = dims[1]*(nx-2)+2, dims[2]*(ny-2)+2 # global number of grid points
    # Derived numerics
    dx, dy     = lx/nx_g, ly/ny_g                   # global
    dt         = min(dx,dy)^2/λ/4.1
    # Array allocation
    qHx        = CUDA.zeros(Float64,nx-1,ny-2)
    qHy        = CUDA.zeros(Float64,nx-2,ny-1)
    # Initial condition
    x0, y0     = coords[1]*(nx-2)*dx, coords[2]*(ny-2)*dy
    xc         = [x0 + ix*dx - dx/2 - 0.5*lx  for ix=1:nx]
    yc         = [y0 + iy*dy - dy/2 - 0.5*ly  for iy=1:ny]
    H          = CuArray(exp.(.-xc.^2 .-yc'.^2))
    t_tic = 0.0
    # Time loop
    for it = 1:nt
        if (it==11) t_tic = Base.time() end
        qHx .= .-λ*diff(H[:,2:end-1], dims=1)/dx
        qHy .= .-λ*diff(H[2:end-1,:], dims=2)/dy
        H[2:end-1,2:end-1] .= H[2:end-1,2:end-1] .- dt*(diff(qHx, dims=1)/dx .+ diff(qHy, dims=2)/dy)
        update_halo(H, neighbors_x, neighbors_y, comm_cart)
    end
    t_toc = (Base.time()-t_tic)
    if (me==0) @printf("Time = %1.4e s, T_eff = %1.2f GB/s \n", t_toc, round((2/1e9*nx*ny*sizeof(lx))/(t_toc/(nt-10)), sigdigits=2)) end
    # Save to visualise
    if do_save file = matopen("$(@__DIR__)/H_$(me).mat", "w"); write(file, "H", Array(H)); close(file) end
    MPI.Finalize()
    return
end

diffusion_2D_mpi(; do_save=do_save)
