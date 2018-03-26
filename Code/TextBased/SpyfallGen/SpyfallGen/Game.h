#pragma once

#include <iostream>
#include <string>
#include <vector>

#include "Player.h";

using namespace std;

class Game
{
public:
	int players = 0;
	string* locations;
	string* characters;

	vector<Player*> playlist;
	
	Game();
	void LoadLoc();
	void LoadChar();

	void Run();
};