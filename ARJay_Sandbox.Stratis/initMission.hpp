/*
	File: initMission.hpp
	Author: ARJay
	Description: mission initialisation
*/

[] spawn {	
	[
		[1528.11,5013.696,8], // Target position
		"SITREP", // SITREP text
		500, // 500m altitude
		200, // 200m radius
		0, // 0 degrees viewing angle
		1 // Clockwise movement
	] spawn BIS_fnc_establishingShot;
};