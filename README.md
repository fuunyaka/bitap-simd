# SIMD BITAP ALGORITHM
Find substring entrance using arm neon feature


### Results
```
# arm-asm implementation
./bitap_neon
2020-06-18T15:59:59+03:00
Running ./bitap_neon
Run on (4 X 900 MHz CPU s)
Load Average: 0.52, 0.58, 0.59
----------------------------------------------------------------------
Benchmark                            Time             CPU   Iterations
----------------------------------------------------------------------
BenchTest/PATTERN_IS_STRING       3747 ns         3770 ns       194783
BenchTest/LITTLE_PATTERN          4141 ns         4081 ns       172308
BenchTest/MEDIUM_PATTERN         10422 ns        10277 ns        56000
BenchTest/BIG_PATTERN            15615 ns        14623 ns        24889
```
```
# c++ implementation
./bitap_cpp
2020-06-18T15:39:05+03:00
Running ./pure_cpp/bitap_cpp
Run on (4 X 900 MHz CPU s)
Load Average: 0.52, 0.58, 0.59
----------------------------------------------------------------------
Benchmark                            Time             CPU   Iterations
----------------------------------------------------------------------
BenchTest/PATTERN_IS_STRING       8957 ns         8998 ns        74667
BenchTest/LITTLE_PATTERN         10724 ns        10254 ns        64000
BenchTest/MEDIUM_PATTERN         13990 ns        13951 ns        44800
BenchTest/BIG_PATTERN            20012 ns        19950 ns        34462 
```
