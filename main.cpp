#include <iostream>

extern "C" bool bitap(const char* str, std::size_t str_size, const char* pattern, std::size_t pattern_size);

int main()
{
    std::string input, pattern;
    std::cout << "Please, enter a string\n>";
    std::getline(std::cin, input);
    std::cout << "Please, enter a pattern\n>";
    std::getline(std::cin, pattern);
    bool found = bitap(input.c_str(), input.size(), pattern.c_str(), pattern.size());
    std::cout << "Pattern" << (found ? " ": " not ") << "found\n";
}