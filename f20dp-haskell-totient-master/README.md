# Totient Range in Haskell

This project has three parts:

1. Sequential Totient Range. It's the `sumTotientSequential` function
   in `src/TotientRange.hs`.
2. An application that uses those functions is in
   `app/Main.hs`. Applications can be profiled for the parallelism
   performance using Threadscope.
3. A benchmark suite in `bench/ParallelBenchmarks.hs`. This is the
   place to compare your different parallel implementations of Totient
   Range.

## Installing the Haskell compiler

Note: _you only need to complete these GHC installation steps once. If
you have already completed the Parallel Haskell labs, then you already
have GHC installed and you can skip this step._

Follow the instructions on the _"Installing Haskell"_ page on Canvas
to install the GHC compiler and the cabal build system.

## Building

To build the code in the `lib/` and `app/` directories:

```
cabal build
```

## Running on the head node or on a normal computer

If using the Robotarium cluster, this is for __running on the head
node__. Or if you are running this on your on computer or a computer
in EM 2.50, use this step.

To run the Haskell implementation of Totient Range, which is
in `app/Main.hs` file:

```
cabal exec -- haskell-totient 1 1000 +RTS -N4
```

The `-N4` flag tells the Haskell runtime system to use 4 CPU
cores. Try it with different numbers of cores.

## Running on a compute node

If using the Robotarium cluster, this is for __running on a comute
node__.

Run the Haskell implementation of Totient Range:

```
srun --cpus-per-task=4 cabal exec -- haskell-totient 1 1000 +RTS -N4
```

The `--cpus-per-task=4` asks the job manager to allocate 4 CPU cores
on a compute node to your job. The `-N4` flag tells the Haskell
runtime system to use 4 CPU cores. Try it with different numbers of
cores. Those two numbers (e.g. 4) should always be the same.

## Profiling

### Profiling parallelism

After you have parallelised your code, you should profile the
parallelism activities within the runtime system. You can use
Threadscope for this.

#### Install Threadscope

You can create an `.eventlog` file on the cluster, you should then
copy that file to your own machine to run the threadscope program on
it.

    mkdir ~/threadscope
    cd ~/threadscope
    wget https://github.com/haskell/ThreadScope/releases/download/v0.2.12/threadscope.linux.gz
    gzip -d threadscope.linux.gz
    chmod 700 threadscope.linux
    mv threadscope.linux threadscope

Then add these lines to your `~/.profile` (or `~/.bash_profile`) file:

    PATH=$PATH:~/threadscope/
    export $PATH

#### Running a program with parallel profiling enabled

    cabal exec -- haskell-totient 1 1000 +RTS -N4 -l

The above example uses 4 cores.

#### Running Threadscope

    threadscope haskell-totient.eventlog

### Systematic benchmarking

Note: _The instructions below explain how to use the criterion library
to systematically benchmark code with lots of repeated runs per
benchmark. To measure the performance of your parallel Haskell code on
the Robtarium cluster for your coursework, you should __follow the
instructions on Canvas__ for benchmarking the program in `app/Main.hs`
using a shell script._

Benchmarks are run with:

    cabal bench --benchmark-options='+RTS -N2 -RTS'

Where 2 is the number of cores I want to run the benchmarks
with. Change that number to try with a different number of CPU cores.

If you want to do this on the Robotarium cluster, build the
benchmarking code on the head node with:

    cabal build --enable-benchmarks

Then run it on one of the compute nodes with:

    srun --cpus-per-task=32 cabal bench --benchmark-options='+RTS -N32 -RTS'

The example above uses 32 CPU cores. In addition to reporting results
to the command line, it also produces a HTML report with runtime
graphs. You could copy this to your local machine to inspect with a
web browser. See the `f20dp-haskell-examples` project on GitLab for
more details of how to do this.

## Optimising parallelism

For your coursework submission, consider the following questions.

Try using different numbers of cores with `-N`. What does Threadscope
show now? Zoom into the start early stages of execution in
Threadscope. What's going on? Why? Now zoom into the latter stages of
execution in Threadscope. What's going on? Why? There's a change in
parallelism behaviour, what part of the Haskell program can be
attributed to that change? Can you change the granularity of parallel
task? How does this affect the parallelism efficiency of your code?
