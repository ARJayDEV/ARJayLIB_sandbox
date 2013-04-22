// ARJAY LIB SETUP -------------------------------------------------------------------------------------------

// inlcude the arjay script library
#include "arjay\arjay_kickstart.sqf"

#include "initBriefing.hpp"

// initial uav camera shot for mission start
//#include "initMission.hpp"


arjay_debug = false; // enable dev tools

// arjay debug mode then allow map teleport on click, and show info on target in crosshairs
// if the crosshairs are held for over 3 seconds on a target, inspect the target in the RPT file
if(arjay_debug) then
{
	// enable map teleport on click
	[] call arjay_mapTeleport;

	// show info of objects that are targeted
	[] call arjay_showInfoOnTarget;
	
	// enemy will ignore player
	//[player] call arjay_invisibleToEnemy;
};


// EXAMPLE MISSION SETTINGS -------------------------------------------------------------------------------------------

// task callbacks

// Move to marker call back
moveToMarker1Callback = 
{
	private ["_player"];
	
	_player = _this select 0;
	
	[format["Player %1, has completed task %2", _player]] call arjay_dump;
};

// Eliminate target calls back to this function once task has been completed
eliminateTarget1Callback = 
{
	private ["_player"];
	
	_player = _this select 0;
	
	[format["Player %1, has completed task %2", _player]] call arjay_dump;
};

// Eliminate target calls back to this function once task has been completed
eliminateTarget2Callback = 
{
	private ["_player"];
	
	_player = _this select 0;
	
	[format["Player %1, has completed task %2", _player]] call arjay_dump;
};

// Eliminate group calls back to this function once task has been completed
eliminateGroup1Callback = 
{
	private ["_player"];
	
	_player = _this select 0;
	
	[format["Player %1, has completed task %2", _player]] call arjay_dump;
};

// Require item calls back to this function once task has been completed
requireItem1Callback = 
{
	private ["_player"];
	
	_player = _this select 0;
	
	[format["Player %1, has completed task", _player]] call arjay_dump;
};

// target practice

[targetPracticeTarget1] call arjay_disableTarget;

// conversation

[conversationTarget1] call arjay_disableAI;
[conversationTarget1] call arjay_stripLoadout;
[conversationTarget1,"GANGSTER4"] call arjay_setLoadout;

{_x setVariable ["BIS_noCoreConversations", TRUE]} forEach [player, conversationTarget1];
player kbAddTopic ["testConversation", "conversation\test_conversation.bikb", "", {call compile preprocessFileLineNumbers "conversation\test_conversation_player.sqf"}];
conversationTarget1 kbAddTopic ["testConversation", "conversation\test_conversation.bikb", "conversation\test_conversation_target1.fsm"];

// camera target units

[cameraTarget1] call arjay_disableAI;
[cameraTarget2] call arjay_disableAI;
[cameraTarget3] call arjay_disableAI;
[cameraTarget4] call arjay_disableAI;
[cameraTarget5] call arjay_disableAI;
[taskTarget1] call arjay_disableAI;
[taskTarget2] call arjay_disableAI;
[taskTarget3] call arjay_disableAI;
[taskTarget4] call arjay_disableAI;

// example loadout units

[gt1] call arjay_disableAI;
[gt2] call arjay_disableAI;
[gt3] call arjay_disableAI;
[gt4] call arjay_disableAI;
[gt5] call arjay_disableAI;
[gt6] call arjay_disableAI;
[gt7] call arjay_disableAI;
[gt8] call arjay_disableAI;
[gt9] call arjay_disableAI;
[gt10] call arjay_disableAI;
[gt11] call arjay_disableAI;
[gt12] call arjay_disableAI;
[gt13] call arjay_disableAI;
[gt14] call arjay_disableAI;
[gt15] call arjay_disableAI;
[gt16] call arjay_disableAI;
[gt17] call arjay_disableAI;
[gt18] call arjay_disableAI;
[gt19] call arjay_disableAI;
[gt20] call arjay_disableAI;
[gt21] call arjay_disableAI;
[gt22] call arjay_disableAI;
[gt23] call arjay_disableAI;
[gt24] call arjay_disableAI;
[gt25] call arjay_disableAI;
[gt26] call arjay_disableAI;
[gt27] call arjay_disableAI;
[gt28] call arjay_disableAI;

// example custom loadout units

[gt29] call arjay_disableAI;
[gt29] call arjay_stripLoadout;
[gt29,"GANGSTER1"] call arjay_setLoadout;

[gt30] call arjay_disableAI;
[gt30] call arjay_stripLoadout;
[gt30,"GANGSTER2"] call arjay_setLoadout;

[gt31] call arjay_disableAI;
[gt31] call arjay_stripLoadout;
[gt31,"GANGSTER3"] call arjay_setLoadout;

[gt32] call arjay_disableAI;
[gt32] call arjay_stripLoadout;
[gt32,"GANGSTER4"] call arjay_setLoadout;

[gt33] call arjay_disableAI;
[gt33] call arjay_stripLoadout;
[gt33,"B_SPEC_OPS"] call arjay_setLoadout;

[gt34] call arjay_disableAI;
[gt34] call arjay_stripLoadout;
[gt34,"B_SPEC_OPS2"] call arjay_setLoadout;