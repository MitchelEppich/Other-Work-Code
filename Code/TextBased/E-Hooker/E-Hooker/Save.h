#pragma once

#include <iostream>
#include <string>

class Node
{
private:
	Node* next;
	Node* prev;
	std::string data;

public:
	Node();
};

class Teach
{
public:
	std::string ftype = "[(\-!-)]";
	std::string fgroup = "[[\-!-]]";
	std::string fheader = "[\-!-]";
	std::string fcomponent = "-!- {\n\n};";
	std::string fitem = "-!-";

	enum { type, group, header, component, item };
	void Save(std::string type, std::string group, std::string header, std::string word);
	void Index(std::string id, int type);
	void Locate(std::string id, int type);
	void Insert(std::string id, int type);
};