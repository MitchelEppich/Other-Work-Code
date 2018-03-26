#include "hashtableprivate.h"

void Refresh(vector<UserAccount> d)
{
	for (int i = 0; i < size; i++)
	{
		Insert(d[i]);
	}
}