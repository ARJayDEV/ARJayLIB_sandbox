/*
	File: arjay_position.sqf
	Author: ARJay
	Description: Various get position helpers
*/

/*
	Generate Random Relative Position on Land
*/
arjay_getRandomRelativePositionLand = 
{		
	private ["_target", "_distance", "_direction", "_position", "_bestPositions"];
	
	_target = _this select 0;
	_distance = _this select 1;
	
	_direction = random 360;
	_position = [_target, _distance, _direction] call BIS_fnc_relPos;
		
	if(surfaceIsWater [_position select 0,_position select 1]) then
	{
		// handy! http://forums.bistudio.com/showthread.php?93897-selectBestPlaces-(do-it-yourself-documentation)
		_bestPositions = selectbestplaces [[_position select 0,_position select 1],200,"(1 + houses)",10,1];
		
		_position = _bestPositions select 0;
		_position = _position select 0;
		_position set [count _position, 0];
	};
	
	_position
};

/*
	Generate Random Relative Position on Water
*/
arjay_getRandomRelativePositionWater = 
{		
	private ["_target", "_distance", "_direction", "_position"];
	
	_target = _this select 0;
	_distance = _this select 1;
	
	_direction = random 360;
	_position = [_target, _distance, _direction] call BIS_fnc_relPos;
	
	while {!(surfaceIsWater [_position select 0,_position select 1])} do {
		_direction = random 360;
		_position = [_target, _distance, _direction] call BIS_fnc_relPos;
	};
	
	_position
};

/*
	Get count of building positions
*/
arjay_getCountBuildingPositions = 
{		
	private ["_building", "_count"];
	
	_building = _this select 0;
	_count = 0;
	while {str(_building buildingPos _count) != "[0,0,0]"} do 
	{
		_count = _count + 1;
	};
	
	_count
};

/*
	Get random building position
*/
arjay_getRandomBuildingPosition = 
{		
	private ["_building", "_count", "_position"];
	
	_building = _this select 0;
	_count = [_building] call arjay_getCountBuildingPositions;
	
	if(_count == 0) then
	{
		_position = getPos _building;
	}
	else
	{
		_position = random _count;
		_position = _building buildingPos _position;
	};
	
	if((_position select 0) == 0) then
	{
		_position = getPos _building;
	};
	
	_position
};

/*
	Get a position on the side of a nearby road
*/
arjay_getSideOfRoadPosition = 
{		
	private ["_target", "_radius", "_roads", "_road", "_position"];
	
	_target = _this select 0;
	_radius = if(count _this > 1) then {_this select 1} else {100;};
	
	_roads = _target nearRoads _radius;
		
	if(count _roads > 1) then		
	{
		_road = getPos (_roads select (random((count _roads)-1)));
		_position = [(_road select 0) + 6, _road select 1, _road select 2];
	}
	else
	{
		_position = _target;
	};
	
	_position
};