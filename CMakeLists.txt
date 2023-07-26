cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    swift-common
    VERSION 0.1.0
    DESCRIPTION "general c++ library with a focus on build time and developer experience"
    HOMEPAGE_URL "https://github.com/btmxh/swift-common"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    swift-common_swift-common
    source/swift-common.cpp
)
add_library(swift-common::swift-common ALIAS swift-common_swift-common)

if(BUILD_SHARED_LIBS)
    message(WARNING "swift-common does not support building to a shared library."
                    "Setting BUILD_SHARED_LIBS to ON will have no effect")
endif()

set_target_properties(
    swift-common_swift-common PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME swift-common
    OUTPUT_NAME swift-common
)

target_include_directories(
    swift-common_swift-common ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    swift-common_swift-common SYSTEM
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(swift-common_swift-common PUBLIC cxx_std_11)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${swift-common_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT swift-common_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of swift-common"
  )
endif()

include(cmake/dev-mode.cmake)
