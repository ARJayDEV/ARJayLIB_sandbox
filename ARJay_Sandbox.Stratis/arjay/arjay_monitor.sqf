/*
	File: arjay_monitor.sqf
	Author: ARJay
	Description: Main Monitoring Loop
*/

arjay_players = [];
arjay_playerPositions = [];
arjay_isMonitoring = false;

/*
	Monitor players loop
*/
arjay_monitor = 
{
	arjay_isMonitoring = true;
	
	[] spawn
	{
		private ["_position"];
		
		while {arjay_isMonitoring} do
		{
			
			// debug ----------------------------------------------------------------------------------------------------------------------------
			if(arjay_debug && arjay_debugLevel > 1 && arjay_debugLevel < 6) then {["-------------------------------------------------------------------------------------------------------"] call arjay_dump;};
			if(arjay_debug && arjay_debugLevel > 1 && arjay_debugLevel < 6) then {["--- MONITOR -------------------------------------------------------------------------------------------"] call arjay_dump;};
			// debug ----------------------------------------------------------------------------------------------------------------------------
		
			// get all players
			arjay_players = [];
			arjay_playerPositions = [];
			
			if(isMultiplayer) then
			{
				arjay_players = playableUnits;
			}
			else
			{
				arjay_players set [0, player];
			};
			
			// all players loop
			{
				// player is not flying
				if!(vehicle _x isKindOf "Air") then
				{
					_position = getPosASL _x;
					arjay_playerPositions set [count arjay_playerPositions, _position];			
				}
				// player is flying
				else
				{
				
				};
			} forEach arjay_players;
			
			
			// activate agents
			if(arjay_agentsActive) then
			{
				[] call arjay_agentSetActiveLocations;
				[] call arjay_getEnvironment;
				[] call arjay_agentHandleAgentControllers;
			};
			

			// garbage collection
			if(arjay_garbageCollectionActive) then
			{
				[] call arjay_collectGarbage;		
			};
			
			sleep 10;
		};
	};
};