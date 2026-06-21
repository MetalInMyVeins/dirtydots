#include <algorithm>
#include <cctype>
#include <iomanip>
#include <iostream>
#include <string>

int main(int argv, char** argc)
{
  // +101.2*C
  //std::string stemp{"+102.3*C"};
  std::string stemp{*(argc + 1)};
  int n{};
  for (auto it{stemp.rbegin()}; it != stemp.rend(); ++it)
  {
    if (*it == '.') break;
    ++n;
  }
  std::string temp{stemp.substr(1, stemp.size() - n - 2)};
  std::cout << "  " << temp << "°C   ";
  return 0;
}


