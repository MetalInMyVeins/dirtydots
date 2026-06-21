#include <ios>
#include <iostream>
#include <iomanip>

int main(int argv, char** argc)
{
  std::string r1{*(argc + 1)}, r2{*(argc + 2)};
  long long r1n{std::stoll(r1)}, r2n{std::stoll(r2)};
  long long diff{r2n - r1n};
  if (diff < 1024) std::cout << " ▼ " << std::fixed << std::setprecision(1) << diff << " B/s  ";
  else if (diff < 1024 * 1024 and diff >= 1024) std::cout << " ▼ " << std::fixed << std::setprecision(1) << diff / 1024.0 << " KiB/s  ";
  else if (diff < 1024 * 1024 * 1024 and diff >= 1024 * 1024) std::cout << " ▼ " << std::fixed << std::setprecision(1) << diff / (1024.0 * 1024.0) << " MiB/s  ";
}
//⬇
//↓▼⇩🢃⇣🔻

