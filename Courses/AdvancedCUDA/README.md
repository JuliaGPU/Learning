# Advanced GPU Computing course

This folder contains the material for an advanced GPU computing course taught in 2023 at the
Swiss National Supercomputing Centre (CSCS), ETH Zurich.


## Part 1

The first part of the course, taught by Tim Besard (JuliaHub), focusses on (advanced) usage
of CUDA.jl and how to analyze and optimize GPU applications written in Julia. It covers:

* Advanced usage of CUDA.jl
    * library integrations and wrappers (CUDA driver API, CUBLAS, etc)
    * programming models (array abstractions, kernels)
    * memory management
    * task-based concurrent GPU computing
* Performance deep-dive
    * application analysis and optimization (using NSight Systems)
    * kernel analysis and optimization (using NSight Compute)

A [YouTube recording](https://www.youtube.com/watch?v=plgbsH9f7gI) is available, with the
following key timestamps:

- [00:00: Introduction to the course](https://youtu.be/plgbsH9f7gI?si=YUNaaOSE6wBQazcm)
- [03:23: Introduction to part 1](https://youtu.be/plgbsH9f7gI?si=JzXyZHY-udQ3-5ZD&t=203)
- [04:59: Presentation of notebook 1-0: Introduction](https://youtu.be/plgbsH9f7gI?si=XuBcHLZrKfFpC_Na&t=299)
- [24:19: Presentation of notebook 1-1: Array programming](https://youtu.be/plgbsH9f7gI?si=MP0pLCqq7Jf13O_5&t=1459)
- [43:18: Presentation of notebook 1-2: Application analysis and optimization](https://youtu.be/plgbsH9f7gI?si=vdtLUUXddL0FN34y&t=2598)
- [1:33:22: Presentation of notebook 1-3: Kernel programming](https://youtu.be/plgbsH9f7gI?si=JRK3kvNFy4KJZC8G&t=5602)
- [2:25:23: Presentation of notebook 1-4: Kernel analysis and optimization](https://youtu.be/plgbsH9f7gI?si=lBBzvY0bKXakUIkU&t=8723)
- [3:19:16: Presentation of notebook 2-1: CUDA libraries](https://youtu.be/plgbsH9f7gI?si=ir5GzmM9MRE_aaNi&t=11956)
- [3:41:08: Presentation of notebook 2-2: Memory management](https://youtu.be/plgbsH9f7gI?si=LkD7WoJEYSBTQbUf&t=13268)
- [4:03:44: Presentation of notebook 2-3: Concurrent computing](https://youtu.be/plgbsH9f7gI?si=AX5FcofuGUqf-rid&t=14624)


## Part 2

The second part of the course, taught by Samuel Omlin (CSCS) deals with more concrete
examples that matter to the HPC community. A [YouTube
recording](https://www.youtube.com/watch?v=Emr9gfcQr9A) is available too, with the following
key timestamps:

- [00:51: High-speed introduction/thoughts on GPU supercomputing](https://youtu.be/Emr9gfcQr9A?si=AwtBlt7cb4Uuit2e&t=51)
- [08:38: Overview on course notebooks of part 1](https://youtu.be/Emr9gfcQr9A?si=YsxejpyKZYAWlUfL&t=518)
- [11:08: Presentation of notebook 1: Memory copy and performance evaluation](https://youtu.be/Emr9gfcQr9A?si=n4z56b09HFlKTQA5&t=668)
- [43:59: Walk through solutions of notebook 2: Application performance evaluation and optimization](https://youtu.be/Emr9gfcQr9A?si=Ko91K4nlGcy0qELv&t=2639)
- [58:29: Presentation on sustainable HPC building block development in Julia](https://youtu.be/Emr9gfcQr9A?si=_xnMqMIko_Qc3s5q&t=3509)
- [1:27:56: Walk through solutions of notebook 3: Using shared memory](https://youtu.be/Emr9gfcQr9A?si=YGaNXnnUeDQ1ope0&t=5276)
- [1:37:35: Walk through solutions of notebook 4: Steering registers and using warp level functions](https://youtu.be/Emr9gfcQr9A?si=QvxhkYCk5HDL4mtF&t=5855)
- [1:57:02: Walk through solutions of notebook 5: Distributed parallelization](https://youtu.be/Emr9gfcQr9A?si=4v9cIjqWjSlVez3j&t=7022)
