# SIMD BITAP ALGORITHM
## Find substring entrance using arm neon feature


### Results
```
# arm-asm implementation
./bitap_neon
1970-01-01T08:22:04+02:00
Running ./bitap_neon
Run on (4 X 900 MHz CPU s)
Load Average: 0.00, 0.00, 0.00
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BenchTest        1365 ns         1365 ns       512715
```
```
# c++ implementation
./bitap_cpp
1970-01-01T08:22:15+02:00
Running ./bitap_cpp
Run on (4 X 900 MHz CPU s)
Load Average: 0.00, 0.00, 0.00
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BenchTest        9533 ns         9533 ns        73342
```
