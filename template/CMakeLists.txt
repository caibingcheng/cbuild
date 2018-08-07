cmake_minimum_required(VERSION 2.8)
project({__CBUILD_PROJECT__})

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin/)

add_executable({__CBUILD_PROJECT__} ${PROJECT_SOURCE_DIR}/src/main.cpp)

