// Automated build command for building CMake projects.
// Usage:
// bd
// bd win64
// bd win32 rel wingui
// bd rel
#include <algorithm>
#include <array>
#include <functional>
#include <memory>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

void execute_command(const std::string&);

#include <functional>

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
  std::vector<std::string> toolchainFiles{"win64", "win32"};
  std::vector<std::string> debrelFlags{"rel"};
  std::vector<std::string> winguiFlags{"wingui"};
  std::string cmdPrefix{"cmake -S . -B "};
  std::string buildDir{};
  bool verbose{false};
  bool toolchain_enabled{false};
  bool debug_flag{true};

  std::vector<std::string> arguments{};
  arguments.reserve(argc - 1);
  for (int i{1}; i < argc; ++i)
  {
    arguments.push_back(*(argv + i));
  }

  for (const auto& tf : toolchainFiles)
  {
    auto iter{std::find(arguments.begin(), arguments.end(), tf)};
    if (iter != arguments.end() and tf == "win64")
    {
      cmdPrefix += "buildwin64 -DCMAKE_TOOLCHAIN_FILE=win64.cmake ";
      buildDir = "buildwin64 ";
      toolchain_enabled = true;
      break;
    }
    else if (iter != arguments.end() and tf == "win32")
    {
      cmdPrefix += "buildwin32 -DCMAKE_TOOLCHAIN_FILE=win32.cmake ";
      buildDir = "buildwin32 ";
      toolchain_enabled = true;
      break;
    }
    else if (iter == arguments.end())
    {
      //cmdPrefix += "build ";
      cmdPrefix += "build -G Ninja ";
      buildDir = "build ";
      toolchain_enabled = false;
      break;
    }
  }

  for (const auto& debrel : debrelFlags)
  {
    auto iter{std::find(arguments.begin(), arguments.end(), debrel)};
    if (iter != arguments.end() and debrel == "rel")
    {
      cmdPrefix += "-DDEBUG_BUILD=OFF ";
      debug_flag = false;
    }
    else
    {
      cmdPrefix += "-DDEBUG_BUILD=ON ";
      debug_flag = true;
    }
  }

  for (const auto& wg : winguiFlags)
  {
    auto iter{std::find(arguments.begin(), arguments.end(), wg)};
    if (iter != arguments.end() and wg == "wingui")
    {
      cmdPrefix += "-DWIN_GUI=ON ";
    }
  }
  
  for (const auto& arg : arguments)
  {
    if (arg == "lin32")
    {
      cmdPrefix += "-DLINUX32=ON ";
    }
  }

  if (!toolchain_enabled)
  {
    if (debug_flag)
    {
      cmdPrefix += "-DCMAKE_C_COMPILER=$CC ";
      cmdPrefix += "-DCMAKE_CXX_COMPILER=$CXX ";
    }
    else
    {
      cmdPrefix += "-DCMAKE_C_COMPILER=/usr/bin/gcc ";
      cmdPrefix += "-DCMAKE_CXX_COMPILER=/usr/bin/g++ ";
    }
  }

  std::cout << sty::fcyan << sty::bol << sty::und << "Executing:" << sty::res << " " << sty::bol << sty::fmagenta << cmdPrefix << sty::res << std::endl;
  std::cout << sty::fcyan;
  execute_command(cmdPrefix);
  //std::string cmdMake{"cmake --build " + buildDir};
  std::string cmdMake{"ninja -C " + buildDir};
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


