#pragma once

#include <string>
#include <iostream>

#include "structure.h"



class Host
{
private:
	Host* head;
	Host* last;

	Host* next;
	Host* prev;

	std::string name;
	int age;
	Structure* structure;

public:
	Host();

	void Reply(std::string sentence);

	void AddHost(Host newHost);
	Host RemoveHost(std::string name);

	Host HostAt(int index);
	int FindHost(std::string name);

	bool Contains(Host searchHost);

	bool operator==(const Host host);
};