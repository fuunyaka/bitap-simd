#include <benchmark/benchmark.h>
#include <iostream>

extern "C" bool bitap(const char* str, std::size_t str_size, const char* pattern, std::size_t pattern_size);


static void BenchTest(benchmark::State& state) {
    for (auto _ : state) {
        char str[] = "beebabubba";
        char pattern[] = "bubb";
        bool found = bitap(str, sizeof(str), pattern, sizeof(pattern));
    }
}


BENCHMARK(BenchTest);
BENCHMARK_MAIN();
