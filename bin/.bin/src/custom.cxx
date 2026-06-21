#include "custom.hxx"
#include <array>
#include <memory>
#include <sstream>

std::stringstream Custom::execute_command(const std::string& command, int& return_code)
{
  std::array<char, 128> buffer;
  std::stringstream result;

  // Open a pipe to capture the command output
  std::unique_ptr<FILE, decltype(&pclose)> pipe(popen((command + " 2>&1").c_str(), "r"), pclose);
  if (!pipe)
  {
    throw std::runtime_error("popen() failed!");
  }

  // Read the output
  while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr)
  {
    result << buffer.data();
  }

  // Get the return code
  return_code = WEXITSTATUS(pclose(pipe.release()));
  return result;
}


