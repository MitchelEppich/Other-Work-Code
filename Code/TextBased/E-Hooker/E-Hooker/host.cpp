#include <iostream>

#include "host.h"
#include "structure.h"



Host::Host()
{
	name = "Rachel";
	age = 1;

	next = nullptr;
	prev = nullptr;

	structure = new Structure();
}

void Host::Reply(std::string sentence)
{
	if (sentence == "") std::cout << "Type anything, I will try my best." << std::endl;
	else std::cout << structure->Construct(sentence) << std::endl; //<< (sentence.find("what is your name?") ? ", also my name is " + name : "") << std::endl;
}

void Host::AddHost(Host newHost)
{
	Host* host = head;

	if (host == nullptr)
	{
		head = &newHost;
	}
	else 
	{
		while (host->next != nullptr)
		{
			host = host->next;
		}

		host->next = &newHost;
		newHost.prev = host;
		newHost.next = nullptr;
	}
}

Host Host::RemoveHost(std::string name)
{
	int index = FindHost(name);
	int count = 0;

	Host* host = head;

	while (count < index)
	{
		if (host == nullptr)
		{
			throw std::exception("Host does not exists in list.");
			return Host();
		} 
		
		host = host->next;
		count++;
	}

	host->prev->next = host->next;
	host->next->prev = host->prev;
	delete host;
}

Host Host::HostAt(int index)
{
	int count = 0;

	Host* host = head;

	while (count < index)
	{
		host = host->next;
		count++;
	}

	return *host;
}

int Host::FindHost(std::string name)
{
	int count = 0;

	Host* host = head;

	while (host != nullptr)
	{
		if (host->name == name)
			return count;

		host = host->next;
		count++;
	}
}

bool Host::Contains(Host searchHost)
{
	int count = 0;

	Host* host = head;

	while (host != nullptr)
	{
		if (*host == searchHost)
			return true;

		host = host->next;
		count++;
	}

	return false;
}

bool Host::operator==(const Host host)
{
	return (host.name == name && host.age == age);
}