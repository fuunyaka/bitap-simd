#pragma once
#include <vector>
#include <string>

class BitapSearch
{
	std::vector<bool> ancestor;
	std::vector<bool> offspring;
	std::string str;
	std::string pattern;

	void shift_ancestor();
	void fill_offspring_vector(const char symbol);
	void and_vectors();
	bool substr_entrance_found();

public:
	BitapSearch() = default;
	BitapSearch(const std::string& str_);
	~BitapSearch() = default;
	bool find_substr(const std::string& pattern_);
};

