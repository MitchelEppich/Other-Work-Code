#include <iostream>

#include "system.h"



bool running = false;

int main()
{
	System system = System();
	system.init();
	while (system.GetState() == system.Running)
	{
		system.Login(0);
	}
	return 0;
}