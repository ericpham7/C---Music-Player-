#pragma once
#include "audioPlayer.hpp"
#include <string>
#include <vector>

class PlaylistManager {
public:
  PlaylistManager(AudioPlayer &player);

  void addTrack(const std::string &filePath);
  void removeTrack(size_t index);
  void clear();

  bool playTrack(size_t index);
  bool playNext();
  bool playPrevious();

  size_t getCurrentIndex() const { return currentIndex; }
  size_t getTrackCount() const { return tracks.size(); }
  std::string getCurrentTrack() const;
  std::vector<std::string> getAllTracks() const { return tracks; }

  void setLoop(bool enabled) { loop = enabled; }
  bool isLooping() const { return loop; }

private:
  AudioPlayer &audioPlayer;
  std::vector<std::string> tracks;
  size_t currentIndex;
  bool loop;
};