#ifndef _SYSTEM_H
#define _SYSTEM_H

#include "UObject.h"

//Enumeration
enum SystemType
{
	Sys_Window, 
	Sys_Game,
	Sys_Input,
	Sys_Graphics,
	Sys_GameTimer
};

//Structs
struct SystemData
{

};

class System :
	public UObject
{
public:
	System();
	virtual ~System();
};

#endif // !_SYSTEM_H