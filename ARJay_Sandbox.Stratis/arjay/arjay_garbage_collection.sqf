/*
	File: arjay_garbage_collection.sqf
	Author: ARJay
	Description: Garbage collection of monitored objects based on distance to players
*/

arjay_garbageCollectionActive = false;
arjay_garbageCollectionObjects = call Dictionary_fnc_new;
arjay_garbageCollectionRadius = 1000;

/*
	Add to garbage collection watch list
*/
arjay_registerForGarbageCollection = 
{
	private ["_target", "_radius", "_callback"];
	
	if!(arjay_garbageCollectionActive) then
	{
		// debug ----------------------------------------------------------------------------------------------------------------------------
		if(arjay_debug && arjay_debugLevel > 1) then {["--- GC - garbage collection system started"] call arjay_dump;};
		// debug ----------------------------------------------------------------------------------------------------------------------------
	
		arjay_garbageCollectionActive = true;
	};
		
	_target = _this select 0;
	_radius = if(count _this > 1) then {_this select 1} else {arjay_garbageCollectionRadius};
	_callback = if(count _this > 2) then {_this select 2} else {""};	
	
	if!(isNull _target) then {
	if!(_target in (arjay_garbageCollectionObjects select 0)) then
	{
		[arjay_garbageCollectionObjects, vehicleVarName _target, [_target, _radius, _callback]] call Dictionary_fnc_set;
	};
	};	
};

/*
	Throw out the trash
*/
arjay_collectGarbage = 
{
	private ["_position", "_radius", "_distance", "_target", "_callback", "_objectsToIgnore", "_objectsToCollect", "_gcObject", "_targetName", "_targetGroup"];
	
	_objectsToIgnore = [];
	_objectsToCollect = [];
	
	// debug ----------------------------------------------------------------------------------------------------------------------------
	if(arjay_debug && arjay_debugLevel > 2) then {[format["--- GC - queued objects %1", (arjay_garbageCollectionObjects select 1)]] call arjay_dump;};
	// debug ----------------------------------------------------------------------------------------------------------------------------
	
	
	// loop through collection objects and compare to all player positions
	// if no player is within collection radius, mark object for collection.
	{		
		_target = _x select 0;
		_position = getPos _target;	
		_radius = _x select 1;	
			
		if!(isNull _target) then {			
		{
			_distance = floor(_position distance _x);		
			
			// debug ----------------------------------------------------------------------------------------------------------------------------
			if(arjay_debug && arjay_debugLevel > 2) then {[format["--- GC - player to object [%1] distance [%2 meters]", vehicleVarName _target, _distance]] call arjay_dump;};
			// debug ----------------------------------------------------------------------------------------------------------------------------
			
			if(_distance > _radius) then
			{	
				_objectsToCollect set [count _objectsToCollect, _target];
			}
			else
			{
				_objectsToIgnore set [count _objectsToIgnore, _target];
			}
			
			} forEach arjay_playerPositions;		
		};
		
	} forEach (arjay_garbageCollectionObjects select 1);
	
	// only collect objects within collection radius of all players
	_objectsToCollect = _objectsToCollect - _objectsToIgnore;
	
	// do the garbage collection
	{
		_target = _x;
		_targetName = vehicleVarName _target;
		_gcObject = [arjay_garbageCollectionObjects, _targetName] call Dictionary_fnc_get;
		_callback = _gcObject select 2;
		
		[arjay_garbageCollectionObjects, _targetName] call Dictionary_fnc_remove;
		
		if!(_callback == "") then
		{
			call compile format["['%1'] call %2", _targetName, _callback];
		};
		
		_targetGroup = group _target;
		deleteVehicle _target;
		deleteGroup _targetGroup;
		
		// debug ----------------------------------------------------------------------------------------------------------------------------
		if(arjay_debug && arjay_debugLevel > 1) then {[format["--- GC - object garbage collected %1", _targetName]] call arjay_dump;};
		// debug ----------------------------------------------------------------------------------------------------------------------------
		
	} forEach _objectsToCollect;
	
	
	if((count (arjay_garbageCollectionObjects select 0)) == 0) then
	{
		// debug ----------------------------------------------------------------------------------------------------------------------------
		if(arjay_debug && arjay_debugLevel > 1) then {["--- GC - garbage collection system stopped"] call arjay_dump;};
		// debug ----------------------------------------------------------------------------------------------------------------------------
		arjay_garbageCollectionActive = false;
	};
};