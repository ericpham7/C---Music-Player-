cmake_minimum_required(VERSION 4.00)
project(musicCpp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# flags for compiler optimizations (release build)
# -Wall -Wextra -O2: warnings and optimization
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -Wall -Wextra -O2")

# flags for debugging (debug build)
# -g: debug symbols, -fsanitize: memory safety and undefined behavior checking
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} -Wall -Wextra -g -fsanitize=address -fsanitize=undefined")

# add the executable target for the music player application
add_executable(music_app src/musicPlayer.cpp src/audioPlayer.mm cocoaUiKit.mm)

#// links AVFOUNDATION - a framework for audio and video playback, recording, and processing on macOS
#// handles audio format decoding, playback control.. etc
target_link_libraries(music_app PRIVATE "-framework AVFoundation" "-framework Foundation")

# // links Cocoa (UIKit) - a framework for macOS application development
# // handles UI elements, event handling, and window management
# // if the platform is macOS, link the Cocoa framework
if(APPLE) 
    target_link_libraries(music_app PRIVATE "-framework Cocoa")
endif()


