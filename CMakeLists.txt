cmake_minimum_required(VERSION 3.16)
project(musicCpp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -Wall -Wextra -O2 -g -fsanitize=address -fsanitize=undefined")

add_executable(music_app src/musicPlayer.cpp)

#// links AVFOUNDATION - a framework for audio and video playback, recording, and processing on macOS
#// handles audio format decoding, playback control.. etc
target_link_libraries(music_app PRIVATE "-framework AVFoundation" "-framework Foundation")


