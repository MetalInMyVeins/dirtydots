/**
 * CMUS happily adds any song to playlist even if the song is already
 * available in the playlist. So this is supposed to be a simple
 * program which removes duplicate tracks from specified .m3u files.
 * CMUS would be configured to run this program at exit.
 * Usage: remdup playlist1 playlist2 ...
 * All <playlist> files would be treated as <playlist.m3u>.
 * Dependency: C++20
*/
#include <filesystem>
#include <fstream>
#include <iostream>
#include <string>
#include <unordered_set>
#include <vector>

namespace fs = std::filesystem;
void remdup(const std::string& pl);

int main(int argv, char** argc)
{
  // This vector would contain the validated playlist filenames.
  std::vector<std::string> plnames{};
  plnames.reserve(argv - 1);

  for (int i{1}; i < argv; ++i)
  {
    // The resulting filename here should be a valid existing
    // playlist filename with .m3u extension.
    std::string filename{*(argc + i)};
    filename += ".m3u";
    // Why not check if the playlist exists or not?
    if (!fs::exists(fs::path{filename}))
      continue;
    plnames.push_back(filename);
  }
  // At this point, plnames should contain valid playlist filenames.
  // So iterate through each playlist and remove duplicates.
  for (auto pl : plnames)
  {
    remdup(pl);
  }
  return 0;
}

// Remove duplicate newline terminated lines from file.
void remdup(const std::string& pl)
{
  std::fstream ifile{pl, std::ios::in};
  if (!ifile.is_open())
  {
    std::cerr << "Playlist file is not open for read\n";
    return;
  }

  std::unordered_set<std::string> uniques{};
  std::string line{};
  while (std::getline(ifile, line))
  {
    if (!uniques.contains(line) and line != "\n")
      uniques.insert(line);
  }
  ifile.close();

  std::fstream ofile{pl, std::ios::out};
  if (!ofile.is_open())
  {
    std::cerr << "Playlist file is not open for write\n";
    return;
  }
  for (auto line : uniques)
  {
    ofile << line << '\n';
  }
  ofile.close();
}


