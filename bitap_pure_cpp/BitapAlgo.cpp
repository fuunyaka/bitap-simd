#include <iostream>
#include "BitapSearch.h"
#include <benchmark/benchmark.h>


static void BM_SomeFunction(benchmark::State& state) {
    for (auto _ : state) {
        // This code gets timed
        BitapSearch engine("beebabubba");
        bool found = engine.find_substr("eebabubb");
    }
}
// Register the function as a benchmark
BENCHMARK(BM_SomeFunction);
// Run the benchmark
BENCHMARK_MAIN();
