/*
	File: arjay_util.sqf
	Author: ARJay
	Description: Various utilities for development and debugging
*/

arjay_dumpLogDestination = "DIAG_LOG"; // GLOBAL_RADIO, TITLE, DIAG_LOG
arjay_dumpLog = "";
arjay_isPositionDumpTracking = false;
arjay_positionDumpTrackingTick = 5;
arjay_isInspectTracking = false;
arjay_inspectDumpTrackingTick = 5;
arjay_startTimer = 0;

/*
	Show instance name of object under cursor
	If held on target for 2 seconds, inspect the target
*/
arjay_showInfoOnTarget = 
{
	[] spawn 
	{		
		private ["_hold", "_text", "_instanceName", "_name", "_typeOf"];
	
		_hold = 0;
	
		while {
			!(isNull cursorTarget) 
			&& (alive cursorTarget) 
			&& ((cursorTarget distance player) <= 100)
		} 
		do
		{
			_instanceName = vehicleVarName cursorTarget;
			_typeOf = typeOf cursorTarget;
			
			if(_name == "Error: No Unit") then {_name = "";};
			
			_text = format ["%1 | %3", _instanceName, _name, _typeOf];
			[_text, 0.3, 1, 0.3, "PLAIN"] call arjay_title;
			
			if(((cursorTarget isKindOf "Man") || (cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Ship"))) then
			{
				if(_hold > 1) then
				{
					[cursorTarget] call arjay_inspect;
					_hold = 0;
				};
				
				_hold = _hold + 1;
			};
			
			sleep 1;
		};		
		sleep 1;
		
		[] call arjay_showInfoOnTarget;
	};
};

/*
	Start timer
*/
arjay_timerStart = 
{
	private ["_text"];
	
	_text = _this select 0;
	arjay_startTimer = diag_tickTime;	
	
	
	[format["%1 [TIMER STARTED]",_text]] call arjay_dump;	
};

/*
	Stop timer
*/
arjay_timerStop = 
{
	private ["_text", "_endTimer"];
	
	_endTimer = diag_tickTime - arjay_startTimer;
	
	_text = _this select 0;
	
	[format["%1 [TIMER ENDED : %2]",_text,_endTimer]] call arjay_dump;	
};

/*
	Dump
*/
arjay_dump = 
{
	private ["_variable", "_variableType"];
	
	_variable = _this select 0;
	_variableType = typename _variable;
	
	if(isNil {_variableType}) then
	{
		["IS NIL"] call arjay_dumpOutput;
	}
	else
	{
		if(_variableType == "STRING") then
		{
			[_variable] call arjay_dumpOutput;
		}
		else
		{
			_variable = str _variable;
			[_variable] call arjay_dumpOutput;
		};
	}
};

/*
	Report Damage
*/
arjay_reportDamage = 
{
	private ["_target"];
		
	_target = _this select 0;	
	
	_text = " ------------------ Monitoring Damage -------------------- ";
	[_text] call arjay_dumpOutput;
	
	_nil = _target addEventHandler["Killed",{
	
		private ["_target", "_killer", "_text"];
	
		_target = _this select 0;
		_killer = _this select 1;
		_text = format["%1 has been killed by %2", vehicleVarName _target, name _killer];
		[_text] call arjay_dumpOutput;
		player globalChat _text;
		
		_text = " ------------------ Monitoring Complete -------------------- ";
		[_text] call arjay_dumpOutput;
	}];
	
	_nil = _target addEventHandler["Dammaged",{
		private ["_target", "_where", "_damage", "_text", "_totalDamage"];
			
		_target = _this select 0;
		_where = _this select 1;
		_damage = _this select 2;
		_totalDamage = getDammage _target;
		_text = format["%1 has been hit in %2 for %3 damage, %4 damage total", vehicleVarName _target, _where, _damage, _totalDamage];
		[_text] call arjay_dumpOutput;
		player globalChat _text;
	}];
	
	_nil = _target addEventHandler["Hit",{
		private ["_target", "_caused", "_damage", "_text", "_totalDamage"];
			
		_target = _this select 0;
		_caused = _this select 1;
		_damage = _this select 2;
		_totalDamage = getDammage _target;
		_text = format["%1 has been hit by %2 for %3 damage, %4 damage total", vehicleVarName _target, _caused, _damage, _totalDamage];
		[_text] call arjay_dumpOutput;
		player globalChat _text;
	}];
};

/*
	Report Animation
*/
arjay_reportAnimation = 
{
	private ["_target"];
		
	_target = _this select 0;	
	
	_nil = _target addEventHandler["AnimChanged",{
		private ["_target", "_anim"];
			
		_target = _this select 0;
		_anim = _this select 1;
		_text = format["%1 animation changed: %2", name _target,_anim];
		[_text] call arjay_dumpOutput;
		
	}];
	
	_nil = _target addEventHandler["AnimDone",{
		private ["_target", "_anim"];
			
		_target = _this select 0;
		_anim = _this select 1;
		_text = format["%1 animation complete: %2", name _target,_anim];
		[_text] call arjay_dumpOutput;
	}];
	
	_nil = _target addEventHandler["AnimStateChanged",{
		private ["_target", "_anim"];
			
		_target = _this select 0;
		_anim = _this select 1;
		_text = format["%1 animation state changed: %2", name _target,_anim];
		[_text] call arjay_dumpOutput;
	}];
};

/*
	Inspect
*/
arjay_inspect = 
{
	private ["_target", "_text", "_pos"];
	
	_target = _this select 0;
	
	_text = " ------------------ Inspecting Target -------------------- ";
	[_text] call arjay_dumpOutput;
	
	_text = format[" name: %1", name _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" instanceName: %1", vehicleVarName _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" data type: %1", typeName _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" class name: %1", typeOf _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is alive: %1", alive _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is player: %1", isPlayer _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is leader: %1", isFormationLeader _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" group: %1", group _target];
	[_text] call arjay_dumpOutput;
	
	/* NOT IN ALPHA?
	text = format[" is pip enabled: %1", isPipEnabled _target];
	[_text] call arjay_dumpOutput;
	*/
	
	/* NOT IN ALPHA?
	_text = format[" is tutorial hints enabled: %1", isTutHintsEnabled _target];
	[_text] call arjay_dumpOutput;
	*/
	
	_text = format[" side: %1", side _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" can stand: %1", canStand _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" can move: %1", canMove _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" able to breathe: %1", isAbleToBreathe _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" on road: %1", isOnRoad getPos _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is engine on: %1", isEngineOn _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is mine active: %1", mineActive _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" damage: %1", damage _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" need reload: %1", needReload _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" morale: %1", morale _target];
	[_text] call arjay_dumpOutput;
	
	/*
	_text = format[" fatigue: %1", getFatigue _target];
	[_text] call arjay_dumpOutput;
	*/
	
	_text = format[" is burning: %1", isBurning _target];
	[_text] call arjay_dumpOutput;
	
	/* NOT IN ALPHA?
	_text = format[" burning: %1", getBuringValue _target];
	[_text] call arjay_dumpOutput;
	*/
	
	_text = format[" bleeding: %1", isBleeding _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" bleeding remaining: %1", getBleedingRemaining _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is touching ground: %1", isTouchingGround _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is under water: %1", underwater _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" knows about: %1", _target knowsAbout player];
	[_text] call arjay_dumpOutput;
	
	_text = format[" current stance: %1", stance _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" current behaviour: %1", behaviour _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" position: %1", getPos _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" position ASL: %1", getPosASL _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" position ATL: %1", getPosATL _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" direction: %1", direction _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" eye direction: %1", eyeDirection _target];
	[_text] call arjay_dumpOutput;
	
	_pos = [_target] call arjay_getPositionText;
	_text = _pos;
	[_text] call arjay_dumpOutput;
	
	_text = format[" nearest building: %1", nearestBuilding _target];
	[_text] call arjay_dumpOutput;
	
	/* NOT IN ALPHA?
	text = format[" is flashlight on: %1", isFlashlightOn _target];
	[_text] call arjay_dumpOutput;
	*/
	
	/* NOT IN ALPHA?
	text = format[" is laser on: %1", isIRLaserOn _target];
	[_text] call arjay_dumpOutput;
	*/
	
	_text = format[" headgear: %1", headgear _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" goggles: %1", goggles _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" primary weapon: %1", primaryWeapon _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" primary weapon items: %1", str primaryWeaponItems _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" secondary weapon: %1", secondaryWeapon _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" secondary weapon items: %1", str secondaryWeaponItems _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" handgun: %1", handgunWeapon _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" handgun items: %1", str handgunItems _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" assignedItems: %1", str assignedItems _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" uniform: %1", uniform _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" uniformItems: %1", str uniformItems _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" vest: %1", vest _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" vest items: %1", str vestItems _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" backpack: %1", backpack _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" backpack items: %1", str backpackItems _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" weapons: %1", str weapons _target];
	[_text] call arjay_dumpOutput;
	
	_text = format[" magazines: %1", str magazines _target];
	[_text] call arjay_dumpOutput;
	
	_text = " ------------------ Inspection Complete -------------------- ";
	[_text] call arjay_dumpOutput;
};

/*
	Inspect Environment
*/
arjay_inspectEnvironment = 
{
	private ["_text", "_date"];
	
	_text = " ------------------ Inspecting Environment -------------------- ";
	[_text] call arjay_dumpOutput;
	
	_text = format[" world: %1", worldName];
	[_text] call arjay_dumpOutput;
	
	_text = format[" mission: %1", missionName];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is server: %1", isServer];
	[_text] call arjay_dumpOutput;
	
	_text = format[" is dedicated server: %1", isDedicated];
	[_text] call arjay_dumpOutput;
	
	_date = date;
	_text = format[" date: %1-%2-%3 %4:%5", _date select 0, _date select 1, _date select 2, _date select 3, _date select 4];
	[_text] call arjay_dumpOutput;
	
	_text = format[" time: %1", daytime];
	[_text] call arjay_dumpOutput;	
	
	_text = format[" overcast: %1", overcast];
	[_text] call arjay_dumpOutput;
	
	_text = format[" fog: %1", fog];
	[_text] call arjay_dumpOutput;
	
	_text = format[" rain: %1", rain];
	[_text] call arjay_dumpOutput;
	
	_text = format[" rainbow: %1", rainbow];
	[_text] call arjay_dumpOutput;
	
	_text = format[" lightnings: %1", lightnings];
	[_text] call arjay_dumpOutput;
	
	_text = format[" humidity: %1", humidity];
	[_text] call arjay_dumpOutput;
	
	_text = format[" gusts: %1", gusts];
	[_text] call arjay_dumpOutput;
	
	_text = format[" waves: %1", waves];
	[_text] call arjay_dumpOutput;
	
	_text = format[" wind direction: %1", windDir];
	[_text] call arjay_dumpOutput;
	
	_text = format[" wind strength: %1", windStr];
	[_text] call arjay_dumpOutput;
	
	_text = format[" next weather change: %1", nextWeatherChange];
	[_text] call arjay_dumpOutput;
	
	_text = format[" fog forecast: %1", fogForecast];
	[_text] call arjay_dumpOutput;
	
	_text = format[" overcast forecast: %1", overcastForecast];
	[_text] call arjay_dumpOutput;
	
	_text = " ------------------ Inspection Complete -------------------- ";
	[_text] call arjay_dumpOutput;
};

/*
	Inspect Classes
*/
arjay_inspectClasses = 
{
	private ["_detailed", "_text", "_cfg", "_item"];
	
	_detailed = if(count _this > 0) then {_this select 0} else {false};
	
	_text = " ------------------ Inspecting Classes -------------------- ";
	[_text] call arjay_dumpOutput;
	
	["CfgWeapons", _detailed] call arjay_inspectConfig;	
	["CfgMagazines", _detailed] call arjay_inspectConfig;	
	["CfgAmmo", _detailed] call arjay_inspectConfig;
	["CfgGlasses", _detailed] call arjay_inspectConfig;	
	["CfgVehicles", _detailed] call arjay_inspectConfig;	
	
	_text = " ------------------ Inspection Complete -------------------- ";
	[_text] call arjay_dumpOutput;
};

/*
	Inspect Config
*/
arjay_inspectConfig = 
{
	private ["_cfg", "_detailed", "_item"];

	_cfg = _this select 0;
	_detailed = _this select 1;

	_text = " ----------- "+_cfg+" ----------- ";
	[_text] call arjay_dumpOutput;
	
	_cfg = configFile >> _cfg;
	
	for "_i" from 0 to (count _cfg)-1 do
	{
		_item = _cfg select _i;
		[_item, _detailed] call arjay_inspectConfigItem;
	};
};

/*
	Inspect Config Item
*/
arjay_inspectConfigItem = 
{
	private ["_item", "_detailed", "_class", "_type", "_scope", "_picture"];

	_item = _this select 0;
	_detailed = _this select 1;

	if(isClass _item) then
	{
		_class = configName _item;
		_type = getNumber(_item >> "type");
		_scope = getNumber(_item >> "scope");
		_picture = getText(_item >> "picture");
		if(_detailed) then
		{
			[format["class: %1 type: %2 scope: %3 picture: %4 path: %5",_class,_type,_scope,_picture,_item]] call arjay_dumpOutput;
		}
		else
		{
			[format["%1",_class]] call arjay_dumpOutput;
		};
		
	};
};

/*
	Inspect Track
*/
arjay_inspectTrack = 
{
	private ["_target"];
	
	_target = _this select 0;
	
	arjay_isInspectTracking = true;
	
	[_target] spawn {
		while {arjay_isInspectTracking} do
		{
			private ["_target"];
			_target = _this select 0;
			[_target] call arjay_inspect;
			sleep arjay_inspectDumpTrackingTick;
		};
	};
};

/*
	Dump Track Position
*/
arjay_dumpTrackPosition = 
{
	private ["_target"];
	
	_target = _this select 0;
	
	arjay_isPositionDumpTracking = true;
	
	[_target] spawn {
		while {arjay_isPositionDumpTracking} do
		{
			private ["_target", "_text"];
			_target = _this select 0;
			_text = [_target] call arjay_getPositionText;
			[_text] call arjay_dumpOutput;	
			sleep arjay_positionDumpTrackingTick;
		};
	};
};

/*
	Dump Output
*/
arjay_dumpOutput = 
{
	private ["_text"];
	
	_text = _this select 0;
	
	switch(arjay_dumpLogDestination) do
	{
		case "TITLE":
		{
			_text = _text + "\n";
		};
		case "GLOBAL_RADIO":
		{
			player globalChat _text;
		};
		case "DIAG_LOG":
		{
			diag_log text _text;
		};
	};	
	
	arjay_dumpLog = arjay_dumpLog + _text;
};

/*
	Flush
*/
arjay_flush = 
{
	if(arjay_dumpLogDestination == "TITLE") then
	{
		[arjay_dumpLog] spawn {
			_text = _this select 0;		
			[_text, 0.2,10,0.2] call arjay_cut;
		};		
	};
	copyToClipboard arjay_dumpLog;
	arjay_isPositionDumpTracking = false;
	arjay_isInspectTracking = false;
	arjay_dumpLog = "";
};

/*
	Return position information in text format
*/
arjay_getPositionText = 
{
	private ["_target", "_pos", "_tX", "_tY", "_tZ", "_grid", "_text"];
	
	_target = _this select 0;
	
	_pos = position _target;
	_tX = _pos select 0;
	_tY = _pos select 1;
	_tZ = _pos select 2;
	_grid = mapGridPosition _pos;
	_text = format[" x:%1 y:%2 z:%3 grid:%4", _tX, _tY, _tZ, _grid];
	_text
};