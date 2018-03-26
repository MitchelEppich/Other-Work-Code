#pragma once

#include <iostream>

#include "client.h"

class System
{
private:
	Client* client;
	Client* clients;
	int state;

public:
	enum { Intializing = 0, Running = 1, Terminating = 2 };

	System();

	void init();

	void Login(int choice);
	void Chat();

	void Print();

	Client* CreateUser();
	void AccessUser();

	void SetClient(Client c);
	Client GetClient();

	void SaveClients();
	Client RetreiveClients();

	bool validateUsername(std::string username);
	bool validatePassword(std::string password);

	void Leave();

	int GetState();
	void SetState(int s);

	// Helpers
	int MaxIndex(int arr[], int len);

};