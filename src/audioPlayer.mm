/*  .mm files are Objective-C++ Source Files, meaning
    that this files allow for mixing c++ code with objective-c
    since AVFoundation is an objective-C language based framwork
*/
#import <AVFoundation/AVFoundation.h>
#include "audioPlayer.hpp"
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
    audioPlayer = new AudioPlayerImpl{nullptr, nullptr};
}

// destructor:
AudioPlayer::~AudioPlayer() {
    // local variable containing conversion of the audioPlayer pointer of void type
    // to AudioPlayerImpl type
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer); // pointer to implementation method

    // to validate if a song was even loaded or not
    // (The null check guards against crashes if no file was ever loaded)
    if (impl->player != nullptr){
        [impl->player stop];
    }
    delete impl; // frees main program struct allocated data
}

// loadFile method:
bool AudioPlayer::loadFile(const string& filePath) {
    // static_cast<AudioPlayerImpl*> - C++ cast operator: safely converts void* to AudioPlayerImpl* pointer type
    // audioPlayer - the void* member variable that holds the hidden implementation (AudioPlayerImpl)
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);

    // @autoreleasepool - Objective-C automatic memory management block: objects created inside are automatically released when block exits
    // The @ symbol is Objective-C syntax for compiler directives/keywords
    @autoreleasepool {
        // NSString* - Objective-C string class pointer type (NSString is an Objective-C class)
        // [NSString stringWithUTF8String:...] - Objective-C method call syntax using square brackets
        // stringWithUTF8String: is a class method that creates an NSString from a C string
        // filePath.c_str() - C++ std::string method that returns a const char* (C-style null-terminated string)
        NSString* path = [NSString stringWithUTF8String:filePath.c_str()];
        
        // impl->currentFile - C++ pointer member access using arrow operator (->)
        // [NSURL fileURLWithPath:path] - Objective-C class method that creates an NSURL file URL from an NSString path
        // NSURL is Objective-C class for representing URLs
        impl->currentFile = [NSURL fileURLWithPath:path];

        // NSError* - Objective-C error object pointer (NSError is used for error reporting in Objective-C)
        // nil - Objective-C equivalent of NULL/nullptr (represents empty/null pointer)
        NSError* error = nil;
        
        // [[AVAudioPlayer alloc] initWithContentsOfURL:... error:...] - Objective-C nested method call syntax
        // [AVAudioPlayer alloc] - calls alloc class method to allocate memory for an AVAudioPlayer object
        // initWithContentsOfURL:error: - initializer method that takes an NSURL and error pointer
        // &error - address-of operator (&) passes a pointer to error so the method can fill it with error details if something fails
        impl->player = [[AVAudioPlayer alloc] initWithContentsOfURL:impl->currentFile error:&error];

        // if (error) - C++ conditional: in Objective-C, error objects are truthy if they exist (non-nil)
        if (error) {
            // cerr - C++ standard error stream (for error output)
            // error.localizedDescription - Objective-C property access using dot notation (property of NSError)
            // UTF8String - NSString method that converts back to C-style const char* string
            cerr << "Failed to load: " << error.localizedDescription.UTF8String << endl;
            // return false - C++ return statement indicating the file load operation failed
            return false;
        }

        // cout - C++ standard output stream (for normal output)
        // impl->player.duration - Objective-C property access: duration property of AVAudioPlayer returns the audio file length in seconds
        // The . operator is used for property access (syntactic sugar for method calls in Objective-C)
        cout << "Loaded: " << filePath << " (" << impl->player.duration << "s)" << endl;
        // return true - C++ return statement indicating the file load operation succeeded
        return true;
    }
    // @autoreleasepool block automatically releases all objects created inside when execution exits this block
}

// play method:
void AudioPlayer::play() {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    
    // if (impl->player) - C++ conditional: checks if player pointer is non-null (truthy check)
    // [impl->player play] - Objective-C method call syntax: calls the play instance method on the AVAudioPlayer object
    // The square brackets [object method] are Objective-C syntax for sending messages/method calls to objects
    if (impl->player != nullptr) {
        [impl->player play];
    }
}

// pause method:
void AudioPlayer::pause() {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    
    // if (impl->player) - C++ conditional: checks if player pointer is non-null (truthy check)
    // [impl->player pause] - Objective-C method call syntax: calls the pause instance method on the AVAudioPlayer object
    if (impl->player != nullptr) {
         [impl->player pause];
    }
}

// stop method:
void AudioPlayer::stop() {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    
    // [impl->player stop] - Objective-C method call syntax: calls the stop instance method on the AVAudioPlayer object
    if (impl->player != nullptr) {
        [impl->player stop];
    }
}

// seek method:
// double seconds - C++ parameter of type double (floating-point number) representing time position in seconds
void AudioPlayer::seek(double seconds) {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    
    if (impl->player != nullptr){
        // impl->player.currentTime - Objective-C property access using dot notation
        // currentTime is a property of AVAudioPlayer that sets/gets the current playback position
        // = seconds - C++ assignment operator: assigns the seconds value to the currentTime property
        impl->player.currentTime = seconds;
    }
}

// this is the total duration of the media file
// double - C++ return type: floating-point number representing duration in seconds
// AudioPlayer::getDuration - scope resolution operator (::) specifies this is the getDuration method of the AudioPlayer class
// const - C++ keyword indicating this method doesn't modify the object's state (const member function)
double AudioPlayer::getDuration() const {
    // auto* - C++11 type inference: compiler deduces AudioPlayerImpl* pointer type automatically
    // static_cast<AudioPlayerImpl*> - C++ cast operator: converts void* to AudioPlayerImpl* pointer
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    
    // return ... - C++ return statement
    // ? : - C++ ternary conditional operator (shorthand if-else)
    // impl->player != nullptr - condition: checks if player pointer is not null
    // impl->player.duration - Objective-C property access: duration property returns total audio file length in seconds
    // : 0 - else case: returns 0.0 (double literal) if player is null
    return impl->player != nullptr ? impl->player.duration : 0;
}

// get the current time in seconds of the media file being played
// this is the time elapsed since the start of the media file
double AudioPlayer::getCurrentTime() const {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    
    // return ... - C++ return statement
    // ? : - C++ ternary conditional operator (shorthand if-else)
    // impl->player - condition: checks if player pointer is truthy (non-null)
    // impl->player.currentTime - Objective-C property access: currentTime property returns current playback position in seconds
    // : 0 - else case: returns 0.0 (double literal) if player is null
    return impl->player ? impl->player.currentTime : 0;
}

// check if the media file is currently playing
// bool - C++ return type: boolean value (true or false) indicating if audio is currently playing
// AudioPlayer::isPlaying - scope resolution operator (::) specifies this is the isPlaying method of the AudioPlayer class
// const - C++ keyword indicating this method doesn't modify the object's state (const member function)
bool AudioPlayer::isPlaying() const {
    auto* impl = static_cast<AudioPlayerImpl*>(audioPlayer);
    
    // return true if the player is not null and the player is playing
    return impl->player != nullptr ? [impl->player isPlaying] : false;
}
