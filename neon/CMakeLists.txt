cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(bitap_neon VERSION 0.0.0 LANGUAGES CXX)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_FIND_ROOT_PATH /usr/arm-linux-gnueabihf)
set(CMAKE_CXX_COMPILER "/usr/bin/arm-linux-gnueabihf-g++")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfpu=neon -pthread")
set(CMAKE_C_COMPILER "/usr/bin/arm-linux-gnueabihf-gcc")
set(CMAKE_CXX_LINK_EXECUTABLE "/usr/bin/arm-linux-gnueabihf-ld")
set(CMAKE_LIBRARY_ARCHITECTURE arm-linux-gnueabihf)
set(CMAKE_EXE_LINKER_FLAGS "--specs=nosys.specs" CACHE INTERNAL "")

SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

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
        bitap_simd.s
        )

add_executable(${PROJECT_NAME} ${SOURCE_FILES})
target_include_directories(${PROJECT_NAME} PUBLIC include)
target_link_libraries(${PROJECT_NAME} benchmark::benchmark)

set_target_properties(${PROJECT_NAME} PROPERTIES CXX_EXTENSIONS OFF)
