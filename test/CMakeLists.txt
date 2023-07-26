cmake_minimum_required(VERSION 3.14)

project(swift-commonTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(swift-common REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(swift-common_test source/swift-common_test.cpp)
target_link_libraries(swift-common_test PRIVATE swift-common::swift-common)
target_compile_features(swift-common_test PRIVATE cxx_std_11)

add_test(NAME swift-common_test COMMAND swift-common_test)

# ---- End-of-file commands ----

add_folders(Test)
