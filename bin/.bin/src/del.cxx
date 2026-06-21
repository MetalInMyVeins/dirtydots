// Delete everything in the current directory
// except the specified ones.
#include <algorithm>
#include <filesystem>
#include <iostream>
#include <vector>

namespace fs = std::filesystem;

int main(int argv, char** argc)
{
  std::vector<std::string> saves{};

  if (argv == 1)
  {
    std::cout << "del needs at least 1 argument.\nAbort\n";
    return 2;
  }

  if (std::string{*(argc + 1)} == "-h")
  {
    std::cout << "Delete everything in the current directory except the specified ones.\n\n"
      << "Usage: del file1 dir1\n\n"
      << "Everything but file1 and dir1 will be deleted.\n"
      << "Running del with no arguments will result in error.\n";
    return 0;
  }

  for (int i{1}; i < argv; ++i)
  {
    saves.push_back(*(argc + i));
  }

  fs::path p{"."};
  for (auto entry : fs::directory_iterator{p})
  {
    fs::path current{fs::path{entry}.filename()};
    auto iter{std::find(saves.begin(), saves.end(), current.string())};
    if (iter != saves.end())
      continue;
    if (fs::is_regular_file(current))
      fs::remove(current);
    else if (fs::is_directory(current))
      fs::remove_all(current);
  }
  return 0;
}


