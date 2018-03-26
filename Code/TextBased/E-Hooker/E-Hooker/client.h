#pragma once

#include <string>
#include <iostream>

#include "host.h"



class Client
{
private:
	Client* next;
	Client* prev;

	std::string username;
	std::string password;
	Host* hosts;
	int maxHosts;
	int hostCount;

public:
	Client();

	void SetPassword(std::string newPassword);
	std::string GetPassword();

	void SetUsername(std::string newUsername);
	std::string GetUsername();

	bool operator==(const Client client);
};