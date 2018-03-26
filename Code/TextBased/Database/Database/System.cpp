#include <iostream>
#include <fstream>
#include <algorithm>
#include <string>
#include "dirent.h"
#include <vector>

#include "System.h"

Node::Node()
{
	next = nullptr;
	prev = nullptr;

	identity = System::UNKNOWN;
	type = "";
	group = "";
	component = "";
	item = "";

	head = nullptr;
	last = nullptr;
}

Node::Node(std::string t, std::string g, std::string c, std::string i, int id)
{
	next = nullptr;
	prev = nullptr;

	identity = id;
	type = t;
	group = g;
	component = c;
	item = i;

	head = nullptr;
	last = nullptr;
}

bool Node::Remove()
{
	if (next != nullptr) next->prev = prev;
	if (prev != nullptr) prev->next = next;

	delete this;

	return true;
}

int Node::Length()
{
	if (this == nullptr || head == nullptr) return 0;

	int count = 0;
	Node* node = head;

	while (node != nullptr)
	{
		count++;
		node = node->next;
	}

	return count;
}

void System::Print(Node* item)
{
	Node* node = item->head;

	while (node != nullptr)
	{
		std::cout << (node->identity == TYPE ? node->type : node->identity == GROUP ? node->group : node->identity == COMPONENT ? node->component : node->item) << std::endl;

		node = node->next;
	}
}

System::System()
{

}

bool System::Consolidate()
{
	std::fstream file("data.txt");
	std::ofstream out;

	out.open("data.txt", std::ios::out);

	call_type = library.head;

	while (call_type != nullptr)
	{
		out << FormatTag(call_type->identity, BEG, call_type->type) << std::endl;

		call_group = call_type->head;

		while (call_group != nullptr)
		{
			out << FormatTag(call_group->identity, BEG, call_group->group) << std::endl;

			call_component = call_group->head;

			while (call_component != nullptr)
			{
				out << FormatTag(call_component->identity, BEG, call_component->component) << std::endl;

				call_item = call_component->head;

				while (call_item != nullptr)
				{
					out << FormatTag(call_item->identity, CUR, call_item->item) << std::endl;

					call_item = call_item->next;
				}

				out << FormatTag(call_component->identity, END, call_component->component) << std::endl;

				call_component = call_component->next;
			}

			out << FormatTag(call_group->identity, END, call_group->group) << std::endl;

			call_group = call_group->next;
		}

		out << FormatTag(call_type->identity, END, call_type->type) << std::endl;

		call_type = call_type->next;
	}

	out.close();

	return true;
}

bool System::Insert(Node* loc, Node* item)
{
	if (item == nullptr)
		return false;

	if (loc->head == nullptr)
	{
		loc->head = item;
		loc->last = item;
	}
	else
	{
		loc->last->next = item;
		item->prev = loc->last;
		item->next = nullptr;
		loc->last = loc->last->next;
	}

	return true;
}

bool System::Add(Node* item)
{

	if (item->type != "") Insert(&library, ((call_type = Locate(item, TYPE)) == nullptr ? call_type = new Node(item->type, "", "", "", TYPE) : nullptr));
	if (item->group != "") Insert(call_type, ((call_group = Locate(item, GROUP)) == nullptr ? call_group = new Node(item->type, item->group, "", "", GROUP) : nullptr));
	if (item->component != "") Insert(call_group, ((call_component = Locate(item, COMPONENT)) == nullptr ? call_component = new Node(item->type, item->group, item->component, "", COMPONENT) : nullptr));
	if (item->item != "") Insert(call_component, ((call_item = Locate(item, ITEM)) == nullptr ? call_item = new Node(item->type, item->group, item->component, item->item, ITEM) : nullptr));
	
	return true;
}

bool System::Index()
{
	std::fstream file("data.txt");
	std::ifstream in;

	in.open("data.txt", std::ios::in);

	std::string input;
	
	while (in.good())
	{
		getline(in, input);
		while (input.find("[-") != -1 && input.find("\\") == -1)
		{
			call_type = new Node();
			call_type->identity = TYPE;

			input.erase(0, 2 + 0);
			input.erase(input.length() - 2, 2);

			call_type->type = input;

			Insert(&library, call_type);

			getline(in, input);
			while (input.find("[[") != -1 && input.find("\\") == -1)
			{
				call_group = new Node();
				call_group->identity = GROUP;

				input.erase(0, 2 + 1);
				input.erase(input.length() - 2, 2);

				call_group->type = call_type->type;
				call_group->group = input;

				Insert(call_type, call_group);

				getline(in, input);
				while (input.find("{") != -1 && input.find("\\") == -1)
				{
					call_component = new Node();
					call_component->identity = COMPONENT;

					input.erase(0, 0 + 2);
					input.erase(input.length() - 2, 2);

					call_component->type = call_type->type;
					call_component->group = call_group->group;
					call_component->component = input;

					Insert(call_group, call_component);

					getline(in, input);
					while (input.find("};") == -1 && input.find("\\") == -1)
					{
						call_item = new Node();
						call_item->identity = ITEM;

						input.erase(0, 0 + 3);
						input.erase(input.length() - 1, input.find(',') != -1 ? 1 : 0);

						call_item->type = call_type->type;
						call_item->group = call_group->group;
						call_item->component = call_component->component;
						call_item->item = input;

						Insert(call_component, call_item);

						getline(in, input);

					}
					getline(in, input);
				}
				getline(in, input);
			}
			getline(in, input);
		}
	}

	in.close();

	return true;
}

Node* System::Retreive(std::string word)
{
	return nullptr;
}

Node* System::Locate(Node* item, int id)
{
	Node* node = new Node();
	std::string word;

	if (id >= TYPE)
	{
		word = item->type;
		node = library.head;

		while (node != nullptr) 
		{
			if (node->type == word) 
				break;
			
			node = node->next; 
		}

		if (node == nullptr) return node;
	}

	if (id >= GROUP)
	{
		word = item->group;
		node = node->head;

		while (node != nullptr) 
		{ 
			if (node->group == word)
				break;
				
			node = node->next; 
		}

		if (node == nullptr) return node;
	}

	if (id >= COMPONENT)
	{
		word = item->component;
		node = node->head;

		while (node != nullptr) 
		{ 
			if (node->component == word)
				break;
			
			node = node->next; 
		}

		if (node == nullptr) return node;
	}

	if (id == ITEM)
	{
		word = item->item;
		node = node->head;

		while (node != nullptr) 
		{ 
			if (node->item == word)
				break;
				
			node = node->next; 
		}

		if (node == nullptr) return node;
	}

	return node;
}

std::string System::FormatTag(int id, int pos, std::string word)
{
	transform(word.begin(), word.end(), word.begin(), toupper);

	switch (pos)
	{
	case 0:
		switch (id)
		{
		case 0: return "";
		case 1: return std::string(0, '\t') + "[-" + word + "-]";
		case 2: return std::string(1, '\t') + "[[" + word + "]]";
		case 3: return std::string(2, '\t') + word + " {";
		case 4: return std::string(3, '\t') + word;
		}

	case 1: 
		switch (id)
		{
		case 0: return "";
		case 1: return std::string(0 , '\t') + word;
		case 2: return std::string(1, '\t') + word;
		case 3: return std::string(2, '\t') + word;
		case 4: return std::string(3, '\t') + word;
		}

	case 2:
		switch (id)
		{
		case 0: return "";
		case 1: return std::string(0, '\t') + "[-\\" + word + "-]";
		case 2: return std::string(1, '\t') + "[[\\" + word + "]]";
		case 3: return std::string(2, '\t') + "};";
		case 4: return std::string(3, '\t') + "\\" + word;
		}
	}

	return "";
}

bool System::operator!=(const Node* node)
{
	return true;
}

bool System::operator==(const Node* node)
{
	return true;
}

void System::Catalogue()
{
	Node* callback_type = nullptr;
	Node* callback_group = nullptr;
	Node* callback_component = nullptr;
	Node* callback_item = nullptr;

	while (true)
	{
		access = 1;
		
		std::string word = "";

		while (true)
		{
			Node* node = nullptr;

			if (access == UNKNOWN)
			{
				std::cout << "Current Access Level : LIBRARY" << std::endl;
				getline(std::cin, word);

				if (word.find("|") != -1) goto end;

				CheckCommand(&node, &word, UNKNOWN);
				if (word == "|-->") goto end;
			}

			if (access == TYPE)
			{
				std::cout << "Current Access Level : TYPE -> LIBRARY" << std::endl;
				getline(std::cin, word);

				if (word.find("|") != -1) goto end;

				callback_type = CheckCommand(&node, &word, TYPE);
				if (word == "|-->") goto end;
			} 
			else 
				if (access > TYPE)
				{
					call_type = callback_type;
				}

			if (access == GROUP)
			{
				std::cout << "Current Access Level : GROUP -> " << call_type->type << std::endl;
				getline(std::cin, word);
				
				if (word.find("|") != -1) goto end;

				callback_group = CheckCommand(&node, &word, GROUP);
				if (word == "|-->") goto end;
			} 
			else 
				if (access > GROUP)
				{
					call_group = callback_group;
				}

			if (access == COMPONENT)
			{
				std::cout << "Current Access Level : COMPONENT -> " << call_group->group << std::endl;
				getline(std::cin, word);
				
				if (word.find("|") != -1) goto end;

				callback_component = CheckCommand(&node, &word, COMPONENT);
				if (word == "|-->") goto end;
			} 
			else 
				if (access > COMPONENT)
				{
					call_component = callback_component;
				}

			if (access == ITEM)
			{
				std::cout << "Current Access Level : ITEM -> " << call_component->component << std::endl;
				getline(std::cin, word);
				
				if (word.find("|") != -1) goto end;

				callback_item = CheckCommand(&node, &word, ITEM);
				if (word == "|-->") goto end;
			}

		end:
			if (word.find("|") != -1)
			{
				if (DeployControl(word))
				{
					break;
				}
			}
			else
				if (node != nullptr)
				{
					Add(node);
				}
		}
		break;
	}
}

Node* System::GetAccessNode()
{
	return access == UNKNOWN ? &library : access == TYPE ? call_type : access == GROUP ? call_group : access == COMPONENT ? call_component : access == ITEM ? call_item : nullptr;
}

bool System::DeployControl(std::string word)
{
	word.erase(0, 1);

	if (word == "close") return true;
	if (word == "clear")
	{
		Node* current = GetAccessNode()->head;

		if (current == nullptr) return false;

		while (current != nullptr)
		{
			if (current->next != nullptr)
			{
				current = current->next;
				current->prev->Remove();
			}
			else current->Remove();
		}
	}

	if (word == "list") 
	{

		if (access == ITEM)
		{
			std::cout << "This level does not contain any elements." << std::endl;
			return false;
		}

		int size = 0;
		Node* current = nullptr;

	start:
		current = GetAccessNode();

		if (size == 0) size = current->Length();
		else { Print(current); size = -1; }

		if (size == 0)
		{
			std::cout << "This level does not contain any elements." << std::endl;
			return false;
		}
		else
			if (size > 5)
			{
				std::cout << "Requested index size : " << size << std::endl;
				std::cout << "Would you still like to continue? (0 = no, 1 = yes)" << std::endl;
				std::cin >> size;
			}

		if (size > 0) goto start;

		return false;
	}
}

Node* System::CheckCommand(Node** node, std::string* word, int id)
{
	std::string cmd;

	transform(word->begin(), word->end(), word->begin(), toupper);

	if (word->find("--") != -1)
	{
		if (word->find("<") == -1 && word->find(">") == -1)
		{
			std::cout << ":: Library";
			if ((*node) != nullptr)
			{
				if ((*node)->type != "") std::cout << " -> " << (*node)->type;
				if ((*node)->group != "") std::cout << " -> " << (*node)->group;
				if ((*node)->component != "") std::cout << " -> " << (*node)->component;
				if ((*node)->item != "") std::cout << " -> " << (*node)->item;
			}
			std::cout << std::endl << std::endl;
			return *node;
		}

		cmd = word->substr(word->length() - 3, 3);
		word->erase(word->length() - 3, 3);
	}

	if (word->length() != 0)
	{
		switch (id)
		{
		case 0: break;
		case 1:
			(*node) = new Node(*word, "", "", "", TYPE);
			break;
		case 2:
			(*node) = new Node(call_type->type, *word, "", "", GROUP);
			break;
		case 3:
			(*node) = new Node(call_type->type, call_group->group, *word, "", COMPONENT);
			break;
		case 4:
			(*node) = new Node(call_type->type, call_group->group, call_component->component, *word, ITEM);
			break;
		}
	}

	if (cmd.find("-->") != -1 && (*word != "" || id == UNKNOWN))
	{
		access = id < ITEM ? id + 1 : id;

		switch (id)
		{
		case 0: break;
		case 1: call_type = *node; break;
		case 2: call_group = *node; break;
		case 3: call_component = *node; break;
		case 4: call_item = *node; break;
		}

		*word = "|-->";
	}

	if (cmd.find("<--") != -1)
	{
		switch (id)
		{
		case 0: break;
		case 1: call_type = nullptr; break;
		case 2: call_group = nullptr; break;
		case 3: call_component = nullptr; break;
		case 4: call_item = nullptr; break;
		}

		access = id > UNKNOWN ? id - 1 : id;

		*word = "|-->";
	}

	return *node;
}

void System::AcquireLibrary(char *dir_name)
{
	DIR *dir; //pointer to an open director
	struct dirent *entry; //stuff in the directory
	struct stat info; //information about each entry

	// open
	dir = opendir(dir_name);
	if (!dir)
	{
		std::cout << " Directory was not found\n" << std::endl;
		return;
	}

	// read
	while ( (entry = readdir(dir)) != NULL)
	{
		if (entry->d_name[0] != '.')
		{
			std::string path = std::string(dir_name) + "/" + std::string(entry->d_name);
			//std::cout << "Entry = " << path << std::endl;
			
			// Get all file contents
			std::string type_name = std::string(entry->d_name);

			if (type_name.find(".txt") != -1)
			{
				type_name.erase(type_name.length() - 4, 4);

				std::fstream file(std::string(entry->d_name));
				std::ifstream in;

				in.open(path, std::ios::in);

				std::string word;
				Node* node = nullptr;

				while (in.good())
				{
					getline(in, word);
					node = new Node(type_name, word, "", "", GROUP);
					Add(node);
				}

				in.close();

			}

			stat(path.c_str(), &info);
			if (S_ISDIR(info.st_mode))
			{
				AcquireLibrary((char*) path.c_str());
			}
		}
	}

	// close
	closedir(dir);
}