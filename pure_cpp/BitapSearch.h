#pragma once
#include <vector>
#include <string>
#include <boost/dynamic_bitset/dynamic_bitset.hpp>

class BitapSearch
{
	boost::dynamic_bitset<> ancestor;
	std::vector<boost::dynamic_bitset<>> offsprings;
	std::string str;
	std::string pattern;

	boost::dynamic_bitset<> get_offspring(const char symbol);
	void push_offspring_vector(const char symbol);
	void precalculate_table_fill();

public:
	BitapSearch() = default;
	BitapSearch(const std::string& str_);
	~BitapSearch() = default;
	bool find_substr(const std::string& pattern_);
};
