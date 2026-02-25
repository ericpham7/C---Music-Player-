// to indicate that this file will only be implemented once PER compilation
#pragma once
#include <string>
using namespace std;


class AudioPlayer{
public:
    AudioPlayer();
    ~AudioPlayer();

    // app's functionality
    bool loadFile(const string &filepath);
    void play();
    void pause();
    void stop();
    void seek(double seconds);

    // getters returning state of the user's current session
    double getDuration() const;
    double getCurrentTime() const;
    bool isPlaying() const;

private:
// Uses a void* pointer to hide Objective-C implementation details from the user (AudioPlayerImpl)
// this pointer will be used to store the implementation details of the audio player object without
// This is a design pattern called "pointer to implementation" (PIMPL)
    void* audioPlayer;
};
