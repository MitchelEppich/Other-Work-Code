#include <iostream>
#include <vector>
#include <fstream>

#include "System.h"

int main()
{
	System sys = System();

	sys.Index();

	//sys.AcquireLibrary((char*) "./gLib");

	sys.Catalogue();

	sys.Consolidate();

	return 0;
}