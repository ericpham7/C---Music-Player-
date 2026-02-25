#include "playListManager.hpp"
#include <iostream>

PlaylistManager::PlaylistManager(AudioPlayer &player)
    : audioPlayer(player), currentIndex(0), loop(false) {}

void PlaylistManager::addTrack(const string &filePath) {
  tracks.push_back(filePath);
  cout << "Added track: " << filePath << endl;
}

void PlaylistManager::removeTrack(size_t index) {
  if (index < tracks.size()) {
    tracks.erase(tracks.begin() +
                 static_cast<std::vector<std::string>::difference_type>(index));
    if (currentIndex >= tracks.size() && currentIndex > 0) {
      currentIndex--;
    }
  }
}

void PlaylistManager::clear() {
  audioPlayer.stop();
  tracks.clear();
  currentIndex = 0;
}

bool PlaylistManager::playTrack(size_t index) {
  if (index >= tracks.size()) {
    return false;
  }

  currentIndex = index;
  if (audioPlayer.loadFile(tracks[index])) {
    audioPlayer.play();
    return true;
  }
  return false;
}

bool PlaylistManager::playNext() {
  if (tracks.empty())
    return false;

  currentIndex++;
  if (currentIndex >= tracks.size()) {
    if (loop) {
      currentIndex = 0;
    } else {
      currentIndex = tracks.size() - 1;
      return false;
    }
  }

  return playTrack(currentIndex);
}

bool PlaylistManager::playPrevious() {
  if (tracks.empty())
    return false;

  if (currentIndex > 0) {
    currentIndex--;
  } else if (loop) {
    currentIndex = tracks.size() - 1;
  } else {
    return false;
  }

  return playTrack(currentIndex);
}

string PlaylistManager::getCurrentTrack() const {
  if (currentIndex < tracks.size()) {
    return tracks[currentIndex];
  }
  return "";
}