#include <iostream>
#include <random>
#include "BitapSearch.h"
#include <benchmark/benchmark.h>

std::pair<std::string, std::string> generate_test(std::size_t string_size, std::size_t pattern_size, std::size_t pattern_offset) {
    if (string_size < pattern_offset + pattern_size)
        return std::make_pair(" ", " ");

    std::random_device dev;
    std::mt19937 gen(dev());
    std::uniform_int_distribution<std::mt19937::result_type> chars(' ', '~');
    std::string str;
    for (auto i = 0; i < string_size; i++) {
        str.push_back(chars(gen));
    }

    std::string pattern(str.begin() + pattern_offset, str.begin() + pattern_offset + pattern_size);

    return  std::make_pair(str, pattern);
}

static void BenchTest(benchmark::State& state, std::size_t string_size, std::size_t pattern_size, std::size_t pattern_offset) {
    std::pair<std::string, std::string> inp = generate_test(string_size, pattern_size, pattern_offset);
    for (auto _ : state) {
        BitapSearch engine(inp.first);
        bool found = engine.find_substr(inp.second);
    }
}

BENCHMARK_CAPTURE(BenchTest, PATTERN_IS_STRING, 5, 5, 0);
BENCHMARK_CAPTURE(BenchTest, LITTLE_PATTERN, 20, 8, 3);
BENCHMARK_CAPTURE(BenchTest, MEDIUM_PATTERN, 50, 30, 7);
BENCHMARK_CAPTURE(BenchTest, BIG_PATTERN, 150, 62, 40);

BENCHMARK_MAIN();
