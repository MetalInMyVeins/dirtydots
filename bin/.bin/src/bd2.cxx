// File: bd2.cxx
// Automated build command for building CMake projects.
// Usage:
// # Debug build
// bd
// # Release build
// bd rel
// # RelWithDebInfo
// bd reldeb
#include <algorithm>
#include <array>
#include <functional>
#include <memory>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

void execute_command(const std::string&);

namespace sty
{
  typedef std::string s;
  //std::function<s(int)> col = [](int x) -> s { return "\033[" + std::to_string(x) + "m"; };
  s col(int x) { return "\033[" + std::to_string(x) + "m"; };

  s res{col(0)};
  s bol{col(1)};
  s und{col(4)};
  s bli{col(5)};
  s inv{col(7)};

  s fblack{col(30)};
  s fred{col(31)};
  s fgreen{col(32)};
  s fyellow{col(33)};
  s fblue{col(34)};
  s fmagenta{col(35)};
  s fcyan{col(36)};
  s fwhite{col(37)};
  
  s bblack{col(40)};
  s bred{col(41)};
  s bgreen{col(42)};
  s byellow{col(43)};
  s bblue{col(44)};
  s bmagenta{col(45)};
  s bcyan{col(46)};
  s bwhite{col(47)};
}

int main(int argc, char** argv)
{
  std::vector<std::string> buildFlags{"deb", "rel", "reldeb"};
  std::string cmakeConfig{"cmake -S . -B "};
  std::string ninjaConfig{"-G Ninja "};
  std::string buildDir{"build"};

  std::vector<std::string> arguments{};
  arguments.reserve(argc - 1);
  for (int i{1}; i < argc; ++i)
  {
    arguments.push_back(*(argv + i));
  }

  cmakeConfig += buildDir + " ";

  // "nn" argument means don't use ninja
  bool noninja{false};
  {
    auto iter{std::find(arguments.begin(), arguments.end(), "nn")};
    if (iter != arguments.end())
      noninja = true;
  }
  if (!noninja)
  {
    cmakeConfig += ninjaConfig;
  }

  // If no build flag exist, default should be "deb".
  int bcount{};
  std::string currbflag{};
  for (const auto& bflag : buildFlags)
  {
    auto iter{std::find(arguments.begin(), arguments.end(), bflag)};
    if (iter == arguments.end())
      ++bcount;
    else
    {
      currbflag = *iter;
      break;
    }
  }
  if (bcount == 3)
    currbflag = "deb";

  if (currbflag == "deb")
    cmakeConfig += "-DCMAKE_BUILD_TYPE=Debug ";
  else if (currbflag == "rel")
  {
    cmakeConfig += "-DCMAKE_BUILD_TYPE=Release ";
    cmakeConfig += "-DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ";
  }
  else if (currbflag == "reldeb")
  {
    cmakeConfig += "-DCMAKE_BUILD_TYPE=RelWithDebInfo ";
    cmakeConfig += "-DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ";
  }

  std::cout << sty::fcyan << sty::bol << sty::und << "Executing:" << sty::res << " " << sty::bol << sty::fmagenta << cmakeConfig << sty::res << std::endl;
  std::cout << sty::fcyan;
  execute_command(cmakeConfig);
  std::string cmdMake{"ninja -C " + buildDir};
  if (noninja)
    cmdMake = "cmake --build " + buildDir;
  std::cout << sty::fcyan << sty::bol << sty::und << "Executing:" << sty::res << " " << sty::bol << sty::fmagenta << cmdMake << sty::res << std::endl;
  std::cout << sty::fgreen;
  execute_command(cmdMake);
  std::cout << sty::res;

  for (const auto& arg : arguments)
  {
    if (arg == "run")
    {
      if (buildDir == "buildwin64 " or buildDir == "buildwin32 ")
        execute_command("rn win");
      else
      {
        execute_command("rn");
      }
    }
  }
}

void execute_command(const std::string& command)
{
  // Open a pipe to execute the command
  std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(command.c_str(), "r"), pclose);
  if (!pipe)
  {
    throw std::runtime_error("popen() failed!");
  }

  // Stream output directly to stdout
  char buffer[128];
  while (fgets(buffer, sizeof(buffer), pipe.get()))
  {
    std::cout << buffer;
    std::cout.flush();  // Ensure immediate output
  }
}


