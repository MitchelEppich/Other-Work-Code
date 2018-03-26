#ifdef _SLINKEDLIST_H_

#include <cstdlib>
#include <string>
#include <vector>

				// helper function for deep copy
				// Used by copy constructor and operator=
template <class T>
void SLinkedList::CopyList(const SLinkedList& ll)
{
	size = ll->size;
	front = nullptr;
	back = nullptr;

	while (ll->back != nullptr)
	{
		Node<T>* node = new Node<T>(ll->data);
		InsertBack(node);
	}
}

// helper function for deep delete
// Used by destructor and copy/assignment
template <class T>
SLinkedList::DeleteList()
{
	Node<T>* prev = nullptr;
	Node<T>* current = front;

	while (current != nullptr)
	{
		Node<T>* prev = current;
		current = current->next;
		delete prev;
	}

	delete this;
}

	  // default constructor
template <class T>
SLinkedList::SLinkedList()
{
	size = 0;
	front = nullptr;
	back = nullptr;
}

	  // copy constructor, performs deep copy of list elements
template <class T>
SLinkedList::SLinkedList(const SLinkedList& ll)
{
	CopyList(ll);
}

	  // destructor
template <class T>
SLinkedList::~SLinkedList()
{
	DeleteList();
}

	  // MUTATORS

	  // Inserts an item at the front of the list
	  // POST:  List contains item at front
	  // PARAM: item = item to be inserted
template <class T>
void SLinkedList::InsertFront(T item)
{
	if (front == nullptr)
	{
		front = new Node<T>(item);
		back = front;
	}
	else
	{
		Node<T>* node = new Node<T>(item);
		node->next = front;
		front = node;
		size++;
	}
}

	  // Inserts an item at the back of the list
	  // POST:  List contains item at back
	  // PARAM: item = item to be inserted
template <class T>
void SLinkedList::InsertBack(T item)
{
	if (back == nullptr)
	{
		back = new Node<T>(item);
		front = back;
	}
	else
	{
		Node<T>* node = new Node<T>(item);
		back->next = node;
		back = node;
		size++;
	}
}

	  // Removes the first occurrence of the supplied parameter
	  // Removes and returns true if found, otherwise returns false if parameter is not found or list is empty
template <class T>
bool SLinkedList::Remove(T item)
{
	Node<T>* prev = nullptr;
	Node<T>* current = front;

	while (current != nullptr)
	{
		if (current->data == item)
		{
			if (prev == nullptr)
			{
				front = current->next;
				delete current;
				return true;
			}
			else
			{
				prev->next = current->next;
				delete current;
				return true;
			}
		}
	}

	return false;
}

	  // Removes all items in the list
template <class T>
void SLinkedList::RemoveAll()
{
	Node<T>* prev = nullptr;
	Node<T>* current = front;

	while (current != nullptr)
	{
		Node<T>* prev = current;
		current = current->next;
		delete prev;
	}
}

	  // ACCESSORS

	  // Returns size of list
template <class T>
int SLinkedList::Size() const
{
	return size;
}

	  // Returns whether the list is empty
template <class T>
bool SLinkedList::IsEmpty() const
{
	return size <= 0;
}

	  // Returns existence of item
template <class T>
bool SLinkedList::Contains(T item) const
{
	Node<T>* current = front;

	while (current != nullptr)
	{
		if (current->data == item)
		{
			return true;
		}
	}

	return false;
}

	  // Returns a pointer to the in-place list item or NULL if item not found
template <class T>
T* SLinkedList::Retrieve(T item)
{
	if (Contains(item))
	{
		Node<T>* current = front;

		while (current != nullptr)
		{
			if (current->data == item)
			{
				return current;
			}
		}
	}

	return nullptr;
}

	  // Returns a vector containing the list contents using push_back
template <class T>
vector<T> SLinkedList::Dump() const
{
	vector<T> dump;

	Node<T>* current = front;

	for (int i = 0; i < size; i++)
	{
		dump.push_back(current->data);

		current = current->next;
	}

	return dump;
}

	  // OVERLOADED OPERATORS

	  // must work in the following cases:
	  // list2 = list1 -> general case
	  // list2 = list2 -> should do nothing
template <class T>
SLinkedList& SLinkedList::operator=(const SLinkedList& ll)
{
	CopyList(ll);
	return this;
}

#endif
