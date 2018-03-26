#include <iostream>

#include "client.h"



Client::Client()
{
	username = "User";
	password = "0000";

	hosts = new Host();
	maxHosts = 2;
	hostCount = 1;
}

void Client::SetPassword(std::string newPassword)
{
	password = newPassword;
}

std::string Client::GetPassword()
{
	return password;
}

void Client::SetUsername(std::string newUsername)
{
	username = newUsername;
}

std::string Client::GetUsername()
{
	return username;
}

bool Client::operator==(const Client client)
{
	return (client.username == username && client.password == password);
}