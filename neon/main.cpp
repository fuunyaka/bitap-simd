#include <benchmark/benchmark.h>

extern "C" bool bitap(const char* str, std::size_t str_size, const char* pattern, std::size_t pattern_size);


static void BM_SomeFunction(benchmark::State& state) {
    for (auto _ : state) {
        bool found = bitap("beebabubba", sizeof("beebabubba"), "eebabubb", sizeof("eebabubb"));
        std::cout<< "Found: " << found << std::endl;
    }
}


BENCHMARK(BM_SomeFunction);
BENCHMARK_MAIN();
