cmake_minimum_required(VERSION 3.20)
project(MusicPlayer LANGUAGES CXX OBJCXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable Objective-C++ for .mm files
set(CMAKE_OBJCXX_STANDARD 17)

# Source files
set(SOURCES
    src/musicPlayer.cpp
    src/audioPlayer.mm
    src/playlistManager.cpp
    src/userInterface.cpp
    src/userInterface.hpp
    src/audioPlayer.hpp
    src/musicPlayer.hpp
    src/playlistManager.hpp
)

# Create executable
add_executable(${PROJECT_NAME} ${SOURCES})

# Include directories
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/src)

# Find and link macOS frameworks
find_library(AVFOUNDATION_FRAMEWORK AVFoundation REQUIRED)
find_library(FOUNDATION_FRAMEWORK Foundation REQUIRED)

target_link_libraries(${PROJECT_NAME} PRIVATE
    ${AVFOUNDATION_FRAMEWORK}
    ${FOUNDATION_FRAMEWORK}
)

# Set output directory
set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

# Add debug symbols for Debug builds
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g")
set(CMAKE_OBJCXX_FLAGS_DEBUG "${CMAKE_OBJCXX_FLAGS_DEBUG} -g")
