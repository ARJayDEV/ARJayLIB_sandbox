/*
	File: arjay_modify.sqf
	Author: ARJay
	Description: Object modification
*/

/*
	Disable AI
*/
arjay_disableAI = 
{		
	private ["_target"];
	
	_target = _this select 0;
	
	_target disableAI "AUTOTARGET";
	_target disableAI "TARGET";
	_target disableAI "MOVE";
	_target disableAI "ANIM";
	_target disableAI "FSM";
};

/*
	Enable AI
*/
arjay_enableAI = 
{		
	private ["_target"];
	
	_target = _this select 0;
	
	_target enableAI "AUTOTARGET";
	_target enableAI "TARGET";
	_target enableAI "MOVE";
	_target enableAI "ANIM";
	_target enableAI "FSM";
};

/*
	Disable Target
*/
arjay_disableTarget = 
{		
	private ["_target"];
	
	_target = _this select 0;
	
	_target disableAI "AUTOTARGET";
	_target disableAI "TARGET";
	_target disableAI "MOVE";
	_target disableAI "ANIM";
};

/*
	Invisible
*/
arjay_invisibleToEnemy = 
{
	private ["_target"];
	
	_target = _this select 0;
	
	_target setCaptive true;
};

/*
	Teleport to Target Position
*/
arjay_teleport = 
{
	private ["_target", "_object", "_offset", "_objectType", "_position", "_direction"];
	
	_target = _this select 0;
	_object = _this select 1;
	_offset = if(count _this > 2) then {_this select 2} else {0;};
	
	_objectType = typename _object;
	
	if(_objectType == "STRING") then
	{
		_position = getMarkerPos _object;		
		_direction = getDir _target;
	}
	else
	{
		_position = position _object;
		_direction = getDir _object;
	};
	
	_position = [_position, _offset, random 360] call BIS_fnc_relPos;
	
	[_target, _position] spawn
	{
		private ["_target", "_position"];
	
		_target = _this select 0;
		_position = _this select 1;	
			
		["",1,4,1] call arjay_cut;
		
		_target setDir _direction;
		_target setPos _position;
	
		sleep 4;	
	}
};

/*
	Teleport to Map Click Position
*/
arjay_mapTeleport = 
{
	onMapSingleClick "vehicle player setPos _pos; true;";
};