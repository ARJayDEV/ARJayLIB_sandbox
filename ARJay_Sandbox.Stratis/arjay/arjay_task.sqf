/*
	File: arjay_task.sqf
	Author: ARJay
	Description: Task Handling	
*/ 

/*
	Create a task to acquire an item
*/
arjay_requireItemTask =
{
	private ["_player", "_target", "_item", "_title", "_description", "_alert", "_assign", "_callback", "_position", "_task"];
	
	_player = _this select 0;
	_target = _this select 1;
	_item = _this select 2;
	_title = if(count _this > 3) then {_this select 3} else {""};
	_description = if(count _this > 4) then {_this select 4} else {""};
	_callback = if(count _this > 5) then {_this select 5} else {""};
	_alert = if(count _this > 6) then {_this select 6} else {true};
	_assign = if(count _this > 7) then {_this select 7} else {true};
	
	_position = getPos _target;
	
	_task = [_player, _position, _title, _description, _alert, _assign] call arjay_createDestinationTask;
		
	[_player, _item, _title, _task, _callback] spawn
	{
		private ["_player", "_item", "_title", "_task", "_callback"];
		_player = _this select 0;
		_item = _this select 1;
		_title = _this select 2;
		_task = _this select 3;
		_callback = _this select 4;
		
		waitUntil {sleep 2; _player hasWeapon _item};
		
		[_task, true, "Item Acquired", _title] call arjay_completeTask;
		
		if!(_callback == "") then
		{
			call compile format["[%1] call %2", _player, _callback];
		};
	};
			
	_task
};

/*
	Create a task to eliminate a group
*/
arjay_eliminateGroupTask =
{
	private ["_player", "_target", "_title", "_description", "_alert", "_assign", "_leader", "_position", "_task", "_callback"];
	
	_player = _this select 0;
	_target = _this select 1;
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_callback = if(count _this > 4) then {_this select 4} else {""};
	_alert = if(count _this > 5) then {_this select 5} else {true};
	_assign = if(count _this > 6) then {_this select 6} else {true};
	
	_leader = leader _target;
	_position = getPos _leader;
	_task = [_player, _position, _title, _description, _alert, _assign] call arjay_createDestinationTask;
		
	[_player, _target, _title, _task, _callback] spawn
	{
		private ["_player", "_target", "_title", "_task", "_text", "_callback", "_groupCount", "_lastGroupCount"];
		_player = _this select 0;
		_target = _this select 1;
		_title = _this select 2;
		_task = _this select 3;
		_callback = _this select 4;
		_groupCount = 0;
		_lastGroupCount = 0;

		while {({alive _x} count (units _target)) > 0} do
		{
			_groupCount = {alive _x} count (units _target);
			
			if(_groupCount < _lastGroupCount) then
			{
				switch(_groupCount) do
				{
					case 1:
					{
						_text = format["%1 target remaining", _groupCount];
						["TaskSucceeded",[_title, _text]] call bis_fnc_showNotification;
					};
					default
					{
						_text = format["%1 targets remaining", _groupCount];
						["TaskSucceeded",[_title, _text]] call bis_fnc_showNotification;
					};
				};
			};
			_lastGroupCount = _groupCount;
			sleep 2;
		};
		
		[_task, true, "All targets eliminated", _title] call arjay_completeTask;
		
		if!(_callback == "") then
		{
			call compile format["[%1] call %2", _player, _callback];
		};
	};
	
	_task
};

/*
	Create a task to eliminate a target
*/
arjay_eliminateTargetTask =
{
	private ["_player", "_target", "_title", "_description", "_alert", "_assign", "_callback", "_position", "_task"];
	
	_player = _this select 0;
	_target = _this select 1;
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_callback = if(count _this > 4) then {_this select 4} else {""};
	_alert = if(count _this > 5) then {_this select 5} else {true};
	_assign = if(count _this > 6) then {_this select 6} else {true};
	
	_position = getPos _target;
	
	_task = [_player, _position, _title, _description, _alert, _assign] call arjay_createDestinationTask;
	
	[_player, _target, _task, _title, _callback] spawn
	{
		private ["_player", "_target", "_task", "_title", "_callback"];
		_player = _this select 0;
		_target = _this select 1;
		_task = _this select 2;
		_title = _this select 3;
		_callback = _this select 4;
		
		waitUntil {sleep 2; !alive _target};
		
		[_task, true, "Target eliminated", _title] call arjay_completeTask;
		
		if!(_callback == "") then
		{
			call compile format["[%1] call %2", _player, _callback];
		};
	};
	
	_task
};

/*
	Create a task to move to a location can be either marker name or object
*/
arjay_moveToTask =
{
	private ["_player", "_target", "_distance", "_title", "_description", "_alert", "_assign", "_callback", "_targetType", "_position", "_task"];
	
	_player = _this select 0;
	_target = _this select 1;	
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_callback = if(count _this > 4) then {_this select 4} else {""};
	_distance = if(count _this > 5) then {_this select 5} else {10};
	_alert = if(count _this > 6) then {_this select 6} else {true};
	_assign = if(count _this > 7) then {_this select 7} else {true};

	_targetType = typename _target;
	
	if(_targetType == "STRING") then
	{
		_position = getMarkerPos _target;
	}
	else
	{
		_position = getPos _target;
	};	
		
	_task = [_player, _position, _title, _description, _alert, _assign] call arjay_createDestinationTask;
	
	[_player, _position, _task, _title, _callback, _distance] spawn
	{
		private ["_player", "_target", "_task", "_title", "_callback", "_distance", "_position"];
		_player = _this select 0;
		_position = _this select 1;
		_task = _this select 2;
		_title = _this select 3;
		_callback = _this select 4;
		_distance = _this select 5;
		
		waitUntil {sleep 2; (getPos _player distance _position) < _distance};
		
		[_task, true, "Completed", _title] call arjay_completeTask;
		
		if!(_callback == "") then
		{
			call compile format["[%1] call %2", _player, _callback];
		};
	};
	
	_task
};

/*
	Create a task to move to a location can be either marker name or object
*/
arjay_getInVehicleTask =
{
	private ["_player", "_target", "_distance", "_title", "_description", "_alert", "_assign", "_callback", "_position", "_task"];
	
	_player = _this select 0;
	_target = _this select 1;	
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_callback = if(count _this > 4) then {_this select 4} else {""};
	_distance = if(count _this > 5) then {_this select 5} else {10};
	_alert = if(count _this > 6) then {_this select 6} else {true};
	_assign = if(count _this > 7) then {_this select 7} else {true};

	_position = getPos _target;	
		
	_task = [_player, _position, _title, _description, _alert, _assign] call arjay_createDestinationTask;
	
	[_player, _target, _task, _title, _callback, _distance] spawn
	{
		private ["_player", "_target", "_task", "_title", "_callback", "_distance"];
		_player = _this select 0;
		_target = _this select 1;
		_task = _this select 2;
		_title = _this select 3;
		_callback = _this select 4;
		_distance = _this select 5;
		
		waitUntil {sleep 2; vehicle _player == _target};
		
		[_task, true, "Completed", _title] call arjay_completeTask;
		
		if!(_callback == "") then
		{
			call compile format["[%1] call %2", _player, _callback];
		};
	};
	
	_task
};

/*
	Create a task with a destination
*/
arjay_createDestinationTask = 
{
	private ["_player", "_position", "_title", "_description", "_alert", "_assign", "_task"];
	
	_player = _this select 0;
	_position = _this select 1;
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_alert = if(count _this > 4) then {_this select 4} else {true};
	_assign = if(count _this > 5) then {_this select 5} else {true};
	
	_task = _player createSimpleTask [_title];
	_task setSimpleTaskDestination _position;
	_task setSimpleTaskDescription [_description, _title, _title];
	
	if(_assign) then
	{
		_task setTaskState "ASSIGNED";
		_player setCurrentTask _task;
	};
	
	if(_alert) then
	{
		["TaskAssigned",[_title, _description]] call bis_fnc_showNotification;
	};
	
	_task
};

/*
	Create a task on a marker position
*/
arjay_createMarkerTask = 
{
	private ["_player", "_target", "_title", "_description", "_alert", "_assign", "_task"];
	
	_player = _this select 0;
	_target = _this select 1;
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_alert = if(count _this > 4) then {_this select 4} else {true};
	_assign = if(count _this > 5) then {_this select 5} else {true};
	
	_task = _player createSimpleTask [_title];	
	_task setSimpleTaskDestination (getMarkerPos _target);
	_task setSimpleTaskDescription [_description, _title, _title];
	
	if(_assign) then
	{
		_task setTaskState "ASSIGNED";
		_player setCurrentTask _task;
	};
	
	if(_alert) then
	{
		["TaskAssigned",[_title, _description]] call bis_fnc_showNotification;
	};
	
	_task
};

/*
	Remove a task
*/
arjay_removeTask =
{
	private ["_target", "_task"];
	
	_target = _this select 0;
	_task = _this select 1;
	
	_target removeSimpleTask _task;
};

/*
	Complete a task
*/
arjay_completeTask =
{
	private ["_task", "_alert", "_alertText", "_titleText"];
	
	_task = _this select 0;
	_alert = if(count _this > 1) then {_this select 1} else {true};	
	_alertText = if(count _this > 2) then {_this select 2} else {"Task Completed"};
	_titleText = if(count _this > 3) then {_this select 3} else {"Task Completed"};
	
	_task setTaskState "SUCCEEDED";
	
	if(_alert) then
	{
		["TaskSucceeded",[_titleText, _alertText]] call bis_fnc_showNotification;
	};	
};

/*
	Cancel a task
*/
arjay_cancelTask =
{
	private ["_task", "_alert", "_alertText", "_titleText"];
	
	_task = _this select 0;
	_alert = if(count _this > 1) then {_this select 1} else {true};
	_alertText = if(count _this > 2) then {_this select 2} else {"Task Canceled"};
	_titleText = if(count _this > 3) then {_this select 3} else {"Task Canceled"};
	
	_task setTaskState "CANCELED";
	
	if(_alert) then
	{
		["TaskCanceled",[_titleText, _alertText]] call bis_fnc_showNotification;
	};	
};

/*
	Failed a task
*/
arjay_failTask =
{
	private ["_task", "_alert", "_alertText", "_titleText"];
	
	_task = _this select 0;
	_alert = if(count _this > 1) then {_this select 1} else {true};
	_alertText = if(count _this > 2) then {_this select 2} else {"Task Failed"};
	_titleText = if(count _this > 3) then {_this select 3} else {"Task Failed"};
	
	_task setTaskState "FAILED";
	
	if(_alert) then
	{
		["TaskFailed",[_titleText, _alertText]] call bis_fnc_showNotification;
	};	
};