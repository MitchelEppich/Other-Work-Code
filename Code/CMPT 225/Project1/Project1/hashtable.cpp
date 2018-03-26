#include "hashtable.h"


			 // hash function, uses Horner's method
			 // Assume input string consists only of lower-case a to z
int HashTable::Hash(string input) const
{
	int h = 0;

	for (int i = 0; i < input.length(); i++)
	{
		int x = input.length() - (i + 1);
		h += (int)( pow(32, x) * (input[i] - 96) ) % maxsize;
	}

	return h;
}

// helper function to find smallest prime number greater than supplied parameter
int HashTable::SmallestPrime(int n) const
{
	while(true)
	{
		if (IsPrime(n)) return n;
		n++;
	}
}

// helper function to determine whether a number is prime
bool HashTable::IsPrime(int n) const
{
	for (int i = 2; i < n; i++) {
		if (n % i == 0 && i != n) return false;
	}
	return true;
}

// Resizes the hashtable into a larger array.
// Return false if n is smaller than current array size or if n is negative.
// Else, set array size to the smallest prime number larger than n
//   and re-hash all contents into the new array, delete the old array and return true.
bool HashTable::Resize(int n)
{
	if (n < 0 || n < size)
		return false;

	vector<UserAccount> d = table->Dump();

	for (int i = 0; i < size; i++)
	{
		Remove(d[i]);
	}

	maxsize = SmallestPrime(n);

	for (int i = 0; i < size; i++)
	{
		Insert(d[i]);
	}

	return true;
}

	  // default constructor
	  // creates an array of size 101
HashTable::HashTable()
{
	table = new SLinkedList<UserAccount>();
	maxsize = 101;
	size = 0;
	for (int i = 0; i < maxsize; i++)
	{
		UserAccount ua = UserAccount();
		ua.SetUsername("[DELETED]");

		table->InsertBack(ua);
	}
	size = 0;
}

	  // parameterized constructor
	  // creates an array of size = smallest prime number > 2n
HashTable::HashTable(int n)
{
	table = new SLinkedList<UserAccount>();
	maxsize = SmallestPrime((2*n) + 1);
	size = 0;
	for (int i = 0; i < maxsize; i++)
	{
		UserAccount ua = UserAccount();
		ua.SetUsername("[DELETED]");

		table->InsertBack(ua);
	}
	size = 0;
}

	  // copy constructor
	  // Creates deep copy of sourceht
HashTable::HashTable(const HashTable& sourceht)
{
	maxsize = sourceht.maxsize;
	size = sourceht.size;

	vector<UserAccount> d = sourceht.table->Dump();

	for (int i = 0; i < size; i++)
	{
		Insert(d[i]);
	}
}

	  // destructor
HashTable::~HashTable()
{
	vector<UserAccount> d = table->Dump();

	for (int i = 0; i < size; i++)
	{
		Remove(d[i]);
	}

	delete table;
}

	  // overloaded assignment operator
HashTable& HashTable::operator=(const HashTable& sourceht)
{
	vector<UserAccount> d = sourceht.table->Dump();

	for (int i = 0; i < size; i++)
	{
		table->RemoveAll();
	}

	for (int i = 0; i < size; i++)
	{
		table->InsertBack(d[i]);
	}
}

	  // Insertion
	  // If item does not already exist, inserts at back of hashed list and returns true
	  //   otherwise returns false
	  // If load factor (before insertion) is above 2/3, expand into a new
	  //   table of smallest prime number size at least double the present table size
	  //   and then insert the item.
bool HashTable::Insert(UserAccount acct)
{
	if (!Search(acct))
	{
		if (LoadFactor() > 2 / 3)
			Resize(2*size);

		int hash_val = Hash(acct.GetUsername());
		int index = hash_val;

		vector<UserAccount> d = table->Dump();

		for (int i = 0; i < size; i++)
		{
			table->RemoveAll();
		}
		
		bool inserted = false;
		int iterations = 0;

		while (!inserted)
		{
			iterations++;

			if (d[index].GetUsername == "[DELETED]")
			{
				d[index] = acct;
				inserted = true;
			}

			// Collision Handler

			index = hash_val + pow(iterations, 2);
			index -= index >= maxsize ? maxsize : 0;

			if (pow(iterations, 2) > maxsize)
				break;
		}

		for (int i = 0; i < size; i++)
		{
			table->InsertBack(d[i]);
		}

		return inserted;
	}

	return false;
}

	  // Removal
	  // If item exists, removes and returns true
	  //   otherwise returns false
bool HashTable::Remove(UserAccount acct)
{
	if (Search(acct))
	{
		vector<UserAccount> d = table->Dump();

		for (int i = 0; i < size; i++)
		{
			table->RemoveAll();
		}

		for (int i = 0; i < size; i++)
		{
			if (d[i].GetUsername() == acct.GetUsername())
			{
				d[i].SetUsername = "[DELETED]";
			}
		}

		for (int i = 0; i < size; i++)
		{
			table->InsertBack(d[i]);
		}
		return true;
	}
	return false;
}

	  // Search
	  // Returns true if item exists, false otherwise
bool HashTable::Search(UserAccount acct) const
{
	vector<UserAccount> d = table->Dump();

	for (int i = 0; i < size; i++)
	{
		if (d[i].GetUsername() == acct.GetUsername())
		{
			return true;
		}
	}

	return false;
}

	  // Retrieval
	  // Returns a pointer to a UserAccount object inside the hash table (linked list)
	  //   if a matching parameter is found, otherwise return NULL
UserAccount* HashTable::Retrieve(UserAccount acct)
{
	if (Search(acct))
	{
		vector<UserAccount> d = table->Dump();

		for (int i = 0; i < size; i++)
		{
			if (d[i].GetUsername() == acct.GetUsername())
			{
				return &d[i];
			}
		}
	}

	return nullptr;
}

	  // Returns the number of items stored in the hash table
int HashTable::Size() const
{
	return size;
}

	  // Returns the size of the underlying array
int HashTable::MaxSize() const
{
	return maxsize;
}

	  // Returns the load factor as size / maxsize.
	  // Note that due to separate chaining, load factor can be > 1.
double HashTable::LoadFactor() const
{
	return size / maxsize;
}