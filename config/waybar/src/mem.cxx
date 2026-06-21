#include <iomanip>
#include <iostream>
#include <string>

int main(int argv, char** argc)
{
  std::string sram{*(argc + 1)};
  double ram{std::stod(sram)};
  double ramgb{ram / 1024.0};
  if (ramgb < 1.0) std::cout << "  " << std::setprecision(2) << ramgb << " GiB  ";
  else if (ramgb >= 1.0) std::cout << "  " << std::setprecision(3) << ramgb << " GiB  ";
  return 0;
}


