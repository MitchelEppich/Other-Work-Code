#include <iostream>
#include <string>
#include <algorithm>

#include "bank.h"



Node::Node(std::string d, std::string t)
{
	data = d;
	type = t;
	next = nullptr;
	prev = nullptr;
}

Bank::Bank()
{
	length = 0;
	head = nullptr;
	last = nullptr;
}

void Bank::Insert(std::string data, std::string type)
{
	Node* node = new Node(data, type);

	length += 1;

	if (last == nullptr)
	{
		head = node;
		last = node;
	}
	else
	{
		last->next = node;
		node->next = nullptr;
		node->prev = last;
		last = node;
	}
}

void Bank::Remove(std::string data)
{
	Node* node = head;

	while (node != nullptr)
	{
		if (node->data == data)
		{
			node->prev->next = node->next;
			node->next->prev = node->prev;
			delete node;
			length -= 1;
			break;
		}

		node = node->next;
	}
}

void Bank::Clean()
{
	Node* node = head;

	while (node != nullptr)
	{
		if (node->data == "")
		{
			if (node->prev != nullptr) node->prev->next = node->next;
			if (node->next != nullptr) node->next->prev = node->prev;
			delete node;
			break;
		}

		node = node->next;
	}
}

std::string Bank::ElementAt(int index)
{
	int count = 0;

	Node* node = head;

	while (node != nullptr)
	{
		if (count == index)
		{
			return node->data;
		}

		node = node->next;
		count += 1;
	}
}

std::string Bank::ElementTypeAt(int index)
{
	int count = 0;

	Node* node = head;

	while (node != nullptr)
	{
		if (count == index)
		{
			return node->type;
		}

		node = node->next;
		count += 1;
	}
}

void Bank::RemoveDuplicates()
{
	Node* current;
	Node* sweep;
	Node* duplicate;
	

}

bool Bank::isEmpty()
{
	return length == 0;
}

int Bank::Length()
{
	return length;
}

int Bank::Find(std::string data)
{
	Node* node = head;
	int count = 0;
	std::string word;

	while (node != nullptr)
	{
		word = node->data;
		transform(word.begin(), word.end(), word.begin(), (int(*)(int))tolower);

		if (word == data)
			return count;

		node = node->next;
		count++;
	}

	return -1;
}

bool Bank::Trim(std::string* data, bool fromStart)
{
	Node* node = head;

	while (node != nullptr)
	{
		if (node->data != "" && data->find(node->data) != std::string::npos)
		{
			int len = node->data.length();
			int start = (fromStart ? 0 : data->length() - len);

			data->erase(start, len);

			return true;
		}

		node = node->next;
	}

	return false;
}