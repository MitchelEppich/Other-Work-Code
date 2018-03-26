#pragma once

#include <iostream>
#include <string>

class Node
{
public:
	Node();
	
	Node(std::string t, std::string g, std::string c, std::string i, int id);

	Node* next;
	Node* prev;

	int identity;
	std::string type;
	std::string group;
	std::string component;
	std::string	item;

	Node* head;
	Node* last;

	int Length();
	bool Remove();
};

class System
{
	/*
		Identity :
			- Type : VERB, NOUN, PRONOUN...
			- Group : ANIMAL, FOOD, PERSON...
			- Component : STYLE, COLOR, SPECIFICATIONS...
			- Item : BLUE, DOG, BURGER...
	*/

public:
	enum identity_t { UNKNOWN, TYPE, GROUP, COMPONENT, ITEM };
	enum position_t { BEG, CUR, END};

	int access = 0;

	Node library;

	Node* call_type;
	Node* call_group;
	Node* call_component;
	Node* call_item;

	System();	

	void Catalogue();

	void Print(Node* item);

	Node* GetAccessNode();

	void AcquireLibrary(char *dir_name);

	Node* CheckCommand(Node** node, std::string* word, int id);

	bool DeployControl(std::string word);

	/*
		Paramater :

		Return :
			- True : No errors
			- False : Error
	*/
	bool Consolidate();

	/*
		Parameter :

		Return :
			- True : No errors
			- False : Error
	*/
	bool Index();

	/*
		Paramater :
			- string word : Word to locate in database

		Return :
			- Node* : Returns pointer to found item
			- nullptr : No matching item found
	*/
	Node* Retreive(std::string word);

	/*
		Parameter : 
			- Node* loc : Where to put new item
			- Node* item : Item to consolidate

		Return :
			- True : Item consolidated
			- False : Failed to find suitable location
	*/
	bool Insert(Node* loc, Node* item); 

	/*
		Parameter :
			- Node* item : Item to locate a place for
		
		Return :
			- True : No duplicates found and place found
			- False : Duplicates found or no suitable place found
	*/
	bool Add(Node* item);

	/*
		Parameter :
			- Node item : Item to check existance
			- int id : Identity to check for

		Return :
			- True : Item exists
			- False : Item does not exists
	*/
	Node* Locate(Node* node, int id);

	/*
		Parameter :
			- identity_t id : Format of return tag
			- position_t pos : Location format of return tag
			- string word : Word to add in to format

		Return :
			- string : Identity was located
			- empty_string : No matching identity
	*/
	std::string FormatTag(int id, int pos, std::string word);

	bool operator!=(const Node* node);
	bool operator==(const Node* node);
};