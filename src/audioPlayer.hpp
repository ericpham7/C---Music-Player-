// to indicate that this file will only be implemented once PER compilation
#pragma once
#include <string>
#include <vector>
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
    double isPlaying() const;

private:
    void *audioPlayer;
};
