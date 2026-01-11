/*  .mm files are Objective-C++ Source Files, meaning
    that this files allow for mixing c++ code with objective-c
    since AVFoundation is an objective-C language based framwork
*/
#import <AVFoundation/AVFoundation.h>
#include "AudioPlayer.hpp"
#include <iostream>
using namespace std;

// struct to implement objective-C objects from AVFoundation
struct AudioPlayerImpl {
    AVAudioPlayer* player; // AVFoundation audio playback engine object (objective-C)
    NSURL* currentFile;    // current file loaded object (objective-C)
};

// audioPlayer class method definitions:

// constructor:
AudioPlayer::AudioPlayer() {
    // void* audioPlayer (in audioPlayer class), is pointing to a new object of AudioPlayerImpl
    audioPlayer = new AudioPlayerImpl(nullptr, nullptr);
}

// destructor:
AudioPlayer::~AudioPlayer() {
    // local variable containing conversion of the audioPlayer pointer of void type
    // to AudioPlayerImpl type
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);

    // to validate if a song was even loaded or not
    // (The null check guards against crashes if no file was ever loaded)
    if (impl->player != nullptr){
        [impl->player stop];
    }
    delete impl; // frees main program struct allocated data
}

// loadFile method:
bool AudioPlayer::loadFile(const string& filePath) {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);

    @autoreleasepool {
        NSString* path = [NSString stringWithUTF8String:filePath.c_str()];
        impl->currentFile = [NSURL fileURLWithPath:path];

        NSError* error = nil;
        impl->player = [[AVAudioPlayer alloc] initWithContentsOfURL:impl->currentFile error:&error];

        if (error) {
            cerr << "Failed to load: " << error.localizedDescription.UTF8String << endl;
            return false;
        }

        // Set audio session category
        AVAudioSession* session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];

        cout << "Loaded: " << filePath << " (" << impl->player.duration << "s)" << endl;
        return true;
    }
}

// play method:
void AudioPlayer::play() {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    if (impl->player) [impl->player play];
}

// pause method:
void AudioPlayer::pause() {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    if (impl->player) [impl->player pause];
}

// stop method:
void AudioPlayer::stop() {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    if (impl->player) [impl->player stop];
}

// seek method:
void AudioPlayer::seek(double seconds) {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    if (impl->player != nullptr){
         impl->player.currentTime = seconds;
    }
}

// this is the total duration of the media file
double AudioPlayer::getDuration() const {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    return impl->player != nullptr ? impl->player.duration : 0;
}

// get the current time in seconds of the media file being played
// this is the time elapsed since the start of the media file
double AudioPlayer::getCurrentTime() const {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    return impl->player ? impl->player.currentTime : 0;
}

// check if the media file is currently playing
bool AudioPlayer::isPlaying() const {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    return impl->player && impl->player.isPlaying;
}
