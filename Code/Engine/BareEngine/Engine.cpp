#include "Engine.h"

// Additional include files
#include "System.h";
#include "Game.h";

#ifndef _DELETEMACRO_H
	#include "deletemacros.h";
#endif // !_DELETEMACRO_H

#ifndef _STRING_H
	#include "string.h";
#endif // !_STRING_H


EngineState Engine::m_EngineState = EngineState::Invalid;

Engine::Engine()
{
	m_EngineState = EngineState::Constructing;
}


Engine::~Engine()
{
	m_EngineState = EngineState::Destroying;
}

// Public Methods
int Engine::RunLoop()
{

}

// Private Methods
int Engine::Intialize()
{
	m_EngineState = EngineState::Intializing;

	Game* game = CreateGame();

	if (!game)
		return false;

	// Add some systems


	return true;
}

int Engine::Draw()
{

}

int Engine::Update()
{

}

int Engine::ShutDown()
{
	m_EngineState = EngineState::ShuttingDown;
	
	for (std::pair<SystemType, System*>, psys : m_mapSystems)
	{
		//if (!psys.second->ShutDown())
		//{
			//Logger::Log("Failed to shutdown system: " + psys->GetSystemType());
			//continue;
		//}

		SafeDelete(psys.second);

		return true;
	}
}

int Engine::AddSystem(System* psys)
{
	/*auto element = m_mapSystems.insert(std::make_pair(psys->GetType(), psys));
	if (element.second)
	{
		return true;
	}*/

	return false;
}

Game* Engine::CreateGame()
{
	if (!AddSystem(new Game(GameData())))
		return nullptr;
	Game* game = GetSystem<Game>(SystemType::Sys_Game);
	if (!game)
		return nullptr;

	if (game->Initialize())
		return nullptr;

	return game;
}