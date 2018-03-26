#pragma once

#include <iostream>
#include <string>

#include "bank.h"



class Archive
{
public:
	std::string identity;
	Bank* bank;
	Archive(std::string name, bool isLibrary);

	void SetBank(std::string arr[], int len);
	std::string GetBankAt(int index);

	int Length();

	bool Load(bool isLibrary);
	bool Save(bool isLibrary);
	void Modify(std::string opt, Bank* target);
};