#ifndef _ENGINE_H
	#define _ENGINE_H

// C Runtime Header Files
#ifndef _WINDOWS_
	#include <Windows.h>
#endif // !_WINDOWS_

#ifndef _MAP_
	#include <map>
#endif // !_MAP_

// Forward Declaration
enum SystemType;

class Game;
class System;

// Enumeration
enum EngineState
{
	Invalid, 
	Constructing,
	Intializing,
	Running,
	ShuttingDown,
	Destroying
};

class Engine
{
public:
	Engine();
	~Engine();

	int RunLoop();

	//void* operator new(size_t size);
	//void operator delete(void* pdelete);

	static EngineState GetEngineState() { return m_EngineState;  }

private:

	int Intialize();
	int Draw();
	int Update();
	int ShutDown();

	// Add a core system to the engine
	int AddSystem(System* psys);
	// Retrieve core system from engine
	template<typename T>
	T* GetSystem(SystemType systype)
	{
		T* psys = static_cast<T*>(m_mapSystems[systype]);
		if (!psys)
		{
			//Logger::Log("System is not valid!");
			return nullptr;
		}

		return psys;
	}

	// Create a game instance
	Game* CreateGame();

	std::map<SystemType, System*> m_mapSystems;
	static EngineState m_EngineState;
};

#endif // !_ENGINE_H
