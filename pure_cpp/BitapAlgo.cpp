#include <iostream>
#include "BitapSearch.h"
#include <benchmark/benchmark.h>


static void BenchTest(benchmark::State& state) {
    for (auto _ : state) {
        BitapSearch engine("beebabubba");
        bool found = engine.find_substr("bubb");
    }
}

BENCHMARK(BenchTest);
BENCHMARK_MAIN();
