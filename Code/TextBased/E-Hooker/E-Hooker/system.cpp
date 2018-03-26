#include <iostream>

#include "system.h"
#include "client.h"
#include "host.h"

#include "structure.h"



System::System()
{

}

void System::init()
{
	SetState(Intializing);

	SetState(Running);
}

void System::Login(int choice)
{
	Host* host = new Host();
	std::string sentence = "";
	switch (choice)
	{
	case 0:
		while (true)
		{
			host->Reply(sentence);
			getline(std::cin, sentence);
		}
		break;
	case 4:
		std::cout << std::endl;
		std::cout << "||||||||||||||||||||" << std::endl;
		std::cout << "|| || WELCOME! || ||" << std::endl;
		std::cout << "||||||||||||||||||||" << std::endl;
		std::cout << "1.-----NEW USER-----" << std::endl;
		std::cout << "2.------LOGIN-------" << std::endl;
		std::cout << "3.------LEAVE-------" << std::endl << std::endl;
		std::cout << "Choice : ";
		std::cin >> choice;
		std::cout << std::endl;
		Login(choice);
		break;
	case 1:
		client = CreateUser();
		break;
	case 2:
		AccessUser();
		break;
	case 3:
		Leave();
		break;
	}
}

void System::Chat()
{

}

void System::Print()
{

}

Client* System::CreateUser()
{
	std::string username = "";
	while (!validateUsername(username))
	{
		std::cout << "What name shall I tell our hosts : ";
		std::cin >> username;
	}

	std::string password = "";
	while (!validatePassword(password))
	{
		std::cout << "What about a password to identify you : ";
		std::cin >> password;
	}

	Client* newClient = new Client();
	newClient->SetUsername(username);
	newClient->SetPassword(password);

	std::cout << std::endl << "Client successfully created : " << std::endl 
		<< "Username : " << username << std::endl 
		<< "Password : " << password << std::endl;

	return newClient;
}

void System::AccessUser()
{
	Client* client = CreateUser();

	Client* current = clients;

	while (current != nullptr)
	{
		if (current == client)
		{
			SetClient(*client);
		}
	}
}

bool System::validateUsername(std::string username)
{
	if (username.length() > 5)
		return true;

	return false;
}

bool System::validatePassword(std::string password)
{
	if (password.length() > 5)
		return true;

	return false;
}

void System::SetClient(Client c)
{
	client = &c;
}

Client System::GetClient()
{
	return *client;
}

void System::SaveClients()
{

}

Client System::RetreiveClients()
{
	return Client();
}

void System::Leave()
{

}

int System::GetState()
{
	return state;
}

void System::SetState(int s)
{
	state = s;
}

// Helpers
int System::MaxIndex(int arr[], int len)
{
	int index = 0;

	for (int i = 0; i < len; i++)
	{
		if (arr[index] < arr[i])
			index = i;
	}

	return index;
}