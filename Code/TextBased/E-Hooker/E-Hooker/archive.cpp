#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>

#include "archive.h"
#include "bank.h"
#include "structure.h "



Archive::Archive(std::string id, bool isLibrary)
{
	identity = id;
	bank = new Bank();

	Load(isLibrary);
}

void Archive::SetBank(std::string arr[], int len)
{
	bank = new Bank();
	bank->length = len;
	for (int i = 0; i < len; i++)
	{
		bank->Insert(arr[i], "unsigned");
	}
}

std::string Archive::GetBankAt(int index)
{
	return bank->ElementAt(index);
}

int Archive::Length()
{
	return bank->length;
}

bool Archive::Load(bool isLibrary)
{
	//std::cout << "Loading " << identity << "..." << std::endl;
	std::ifstream loadFile;

	loadFile.open(identity + ".txt", std::ios::in);

	while (loadFile.good())
	{
		std::string word, type = "";
		getline(loadFile, word);

		if (!isLibrary)
		{
			getline(loadFile, type);
		}
			
		bank->Insert(word, type);
	}

	loadFile.close();

	//if (!isLibrary) bank->Clean();

	return true;
}

bool Archive::Save(bool isLibrary)
{
	//std::cout << "Saving " << identity << "..." << std::endl;

	//if (!isLibrary) bank->Clean();

	std::fstream file(identity + ".txt");
	std::ofstream saveFile;

	saveFile.open(identity + ".txt", std::ios::out);

	Node* node = bank->head;

	while(node != nullptr)
	{
		if (node->data == "")
		{
			node = node->next;
			continue;
		}

		saveFile << node->data << std::endl;
		if (!isLibrary) saveFile << node->type << std::endl;

		node = node->next;
	}

	saveFile.close();
	
	return true;
}

void Archive::Modify( std::string opt, Bank* target)
{
	if (opt == "+i")
	{
		if (bank->head == nullptr)
		{
			bank->head = target->head;
			bank->last = target->last;
		}
		else
		{
			bank->last->next = target->head;
			target->head->prev = bank->last;
		}

		bank->length += target->length;
	}

	if (opt == "-i") bank->Remove(target->ElementAt(0));

	Save(false);
}