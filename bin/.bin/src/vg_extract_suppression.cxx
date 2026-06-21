// Extracts suppression data from valgrind log file
// Usage: vg_extract_suppression supp.log supp.supp
#include <fstream>
#include <ios>
#include <iostream>
#include <string>

int main(int argv, char** argc)
{
  std::fstream ifile{*(argc + 1), std::ios::in};
  std::fstream ofile{"supp.supp", std::ios::out};
  std::string line{};
  bool feed{false};

  while (std::getline(ifile, line))
  {
    if (line == "{")
      feed = true;
    if (line == "}")
    {
      feed = false;
      ofile << "}" << std::endl;
    }
    if (feed)
    {
      ofile << line << std::endl;
    }
  }

  ofile.close();
  ifile.close();
  return 0;
}


