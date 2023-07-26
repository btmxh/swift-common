if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/swift-common-${PROJECT_VERSION}"
      CACHE PATH ""
  )
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package swift-common)

install(
    DIRECTORY
    include/
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT swift-common_Development
)

install(
    TARGETS swift-common_swift-common
    EXPORT swift-commonTargets
    RUNTIME #
    COMPONENT swift-common_Runtime
    LIBRARY #
    COMPONENT swift-common_Runtime
    NAMELINK_COMPONENT swift-common_Development
    ARCHIVE #
    COMPONENT swift-common_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    swift-common_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(swift-common_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${swift-common_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT swift-common_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${swift-common_INSTALL_CMAKEDIR}"
    COMPONENT swift-common_Development
)

install(
    EXPORT swift-commonTargets
    NAMESPACE swift-common::
    DESTINATION "${swift-common_INSTALL_CMAKEDIR}"
    COMPONENT swift-common_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
