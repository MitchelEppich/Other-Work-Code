#pragma once

#include <iostream>
#include <string>



class Node
{
public:
	std::string data;
	std::string type;
	Node* next;
	Node* prev;

	Node(std::string d, std::string t);
};

class Bank
{
public:
	Node* head;
	Node* last;

	int length = 0;

	Bank();

	void Insert(std::string data, std::string type);
	void Remove(std::string data);
	std::string ElementAt(int index);
	std::string ElementTypeAt(int index);
	void RemoveDuplicates();
	bool isEmpty();
	int Length();

	void Clean();

	int Find(std::string data);
	bool Trim(std::string* data, bool fromStart);

};