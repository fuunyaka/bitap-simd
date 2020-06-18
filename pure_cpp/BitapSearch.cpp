#include "BitapSearch.h"
#include <algorithm>

BitapSearch::BitapSearch(const std::string& str_) : str(str_) {}

boost::dynamic_bitset<> BitapSearch::get_offspring(const char symbol) {
	char offset = symbol - ' ';
	return offsprings[offset];
}

void BitapSearch::push_offspring_vector(const char symbol) {
	boost::dynamic_bitset<> offspring;
	offspring.resize(pattern.size());
	for (std::size_t i = 1; i < pattern.size()+1; i++) {
		offspring[pattern.size()-i] = (pattern[i-1] == symbol);
	}
	offsprings.push_back(offspring);
	return;
}

void BitapSearch::precalculate_table_fill() {
	std::string alphabet = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
	for (auto i : alphabet) {
		push_offspring_vector(i);
	}
}

bool BitapSearch::find_substr(const std::string& pattern_) {
	pattern = pattern_;
	if (pattern.size() > str.size())
		return false;
	
	precalculate_table_fill();
	ancestor.resize(pattern.size());
	

	for (auto i : str) {
		ancestor >>= 1;
		ancestor[ancestor.size() - 1] = true;
		auto offspring = get_offspring(i);
		ancestor &= offspring;
		if (ancestor[0])
			return true;
	}
	return false;
}
