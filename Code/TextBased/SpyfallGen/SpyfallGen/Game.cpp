#include <iostream>
#include <fstream>
#include <ctime>

#include "Game.h"

int main()
{
	int num;
	cout << "How many players : ";
	cin >> num;

	Game* game = new Game();

	game->players = num;
	//game->LoadChar();
	//game->LoadLoc();

	cout << "Loading Locations..." << endl;
	ifstream loadFile;

	loadFile.open("location.txt", ios::in);

	const int length = 100;

	string location[length];

	for (int i = 0; i < length; i++)
	{
		getline(loadFile, location[i]);
	}

	loadFile.close();

	game->locations = location;

	cout << "Loading Characters..." << endl;

	loadFile.open("character.txt", ios::in);

	const int length2 = 320;

	string character[length2];

	for (int i = 0; i < length2; i++)
	{
		getline(loadFile, character[i]);
	}

	loadFile.close();

	game->characters = character;

	game->Run();

	return 0;
}

Game::Game()
{}

void Game::Run()
{
	srand(hash3(time., time.tv_usec, getpid()));

	int spy = 10;//(int)(rand() % players);

	//string loc = *(locations + (int)(rand() % 100));
	string cha = *(characters + (int)(rand() % 320));

	for (int i = 0; i < players; i++)
	{
		if (i == spy)
		{
			playlist.push_back(new Player("Spy", "???"));
		} 
		else
		{
			string loc = *(locations + (int)(rand() % 100));
			

			playlist.push_back(new Player(cha, loc));
		}
	}

	Player* player;
	string one, two, three;

	player = playlist.at(0);

	cout << "Role : " << player->role << endl;
	cout << "Location : " << player->location << endl;
	cout << endl << "Enter 'y' and press enter before you leave...";
	cin >> one;
	cin.clear();
	for (int i = 0; i < 100; i++)
		cout << endl;

	player = playlist.at(1);

	cout << "Role : " << player->role << endl;
	cout << "Location : " << player->location << endl;
	cout << endl << "Enter 'y' and press enter before you leave...";
	cin >> two;
	cin.clear();
	for (int i = 0; i < 100; i++)
		cout << endl;

	player = playlist.at(2);

	cout << "Role : " << player->role << endl;
	cout << "Location : " << player->location << endl;
	cout << endl << "Enter 'y' and press enter before you leave...";
	cin >> three;
	cin.clear();
	for (int i = 0; i < 100; i++)
		cout << endl;
}

void Game::LoadChar()
{
	cout << "Loading Characters..." << endl;
	ifstream loadFile;

	loadFile.open("character.txt", ios::in);

	const int length = 320;

	string character[length];

	for (int i = 0; i < length; i++)
	{
		getline(loadFile, character[i]);
	}

	loadFile.close();

	characters = character;
}

void Game::LoadLoc()
{
	cout << "Loading Locations..." << endl;
	ifstream loadFile;

	loadFile.open("location.txt", ios::in);

	const int length = 100;

	string location[length];

	for (int i = 0; i < length; i++)
	{
		getline(loadFile, location[i]);
	}

	loadFile.close();

	locations = location;
}