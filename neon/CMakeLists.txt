cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(bitap_neon VERSION 0.0.0 LANGUAGES CXX ASM)


include(FetchContent)

FetchContent_Declare(googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        )
FetchContent_GetProperties(googletest)
if (NOT googletest_POPULATED)
    FetchContent_Populate(googletest)
    add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})
endif ()


FetchContent_Declare(googlebenchmark
        GIT_REPOSITORY https://github.com/google/benchmark
        )
FetchContent_GetProperties(googlebenchmark)
if (NOT googlebenchmark_POPULATED)
    FetchContent_Populate(googlebenchmark)
    add_subdirectory(${googlebenchmark_SOURCE_DIR} ${googlebenchmark_BINARY_DIR})
endif ()


set(SOURCE_FILES
        main.cpp
        bitap_simd.S
        )

add_executable(${PROJECT_NAME} ${SOURCE_FILES})
target_include_directories(${PROJECT_NAME} PUBLIC include)
target_link_libraries(${PROJECT_NAME} benchmark::benchmark)
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_EXTENSIONS OFF)
