#include "BitapSearch.h"
#include <algorithm>

BitapSearch::BitapSearch(const std::string& str_) : str(str_) {}


void BitapSearch::shift_ancestor() {
	std::rotate(ancestor.begin(), ancestor.end() - 1, ancestor.end());
	ancestor[0] = true;
	return;
}

void BitapSearch::fill_offspring_vector(const char symbol) {
	offspring.resize(pattern.size());
	for (std::size_t i = 0; i < pattern.size(); i++) {
		if (pattern[i] == symbol)
			offspring[i] = true;
	}
	return;
}

void BitapSearch::and_vectors() {
	for (std::size_t i = 0; i < pattern.size(); i++) {
		ancestor[i] = offspring[i] & ancestor[i];
	}
	offspring.clear();
	return;
}

bool BitapSearch::substr_entrance_found() {
	if (ancestor.size() > 0) {
		return ancestor.back();
	}
	return false;
}

bool BitapSearch::find_substr(const std::string& pattern_) {
	pattern = pattern_;
	if (pattern.size() > str.size())
		return false;

	ancestor.resize(pattern.size());
	for (auto i : str) {
		shift_ancestor();
		fill_offspring_vector(i);
		and_vectors();
		if (substr_entrance_found())
			return true;
	}
	return false;
}