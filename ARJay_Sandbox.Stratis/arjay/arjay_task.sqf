/*
	File: arjay_task.sqf
	Author: ARJay
	Description: Task Handling	
*/ 

/*
	Create a task to acquire an item
*/
arjay_requireItem =
{
	private ["_player", "_target", "_item", "_title", "_description", "_alert", "_assign", "_task"];
	
	_player = _this select 0;
	_target = _this select 1;
	_item = _this select 2;
	_title = if(count _this > 3) then {_this select 3} else {""};
	_description = if(count _this > 4) then {_this select 4} else {""};
	_alert = if(count _this > 5) then {_this select 5} else {true};
	_assign = if(count _this > 6) then {_this select 6} else {true};
	
	_task = [_player, _target, _title, _description, _alert, _assign] call arjay_createTargetTask;
		
	[_player, _item, _title, _task] spawn
	{
		private ["_player", "_item", "_title", "_task"];
		_player = _this select 0;
		_item = _this select 1;
		_title = _this select 2;
		_task = _this select 3;
		
		waitUntil {sleep 5; _player hasWeapon _item};
		
		[_task, true, "Item Acquired", _title] call arjay_completeTask;	
	};
			
	_task
};

/*
	Create a task to eliminate a group
*/
arjay_eliminateGroup =
{
	private ["_player", "_target", "_title", "_description", "_alert", "_assign", "_leader", "_task"];
	
	_player = _this select 0;
	_target = _this select 1;
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_alert = if(count _this > 4) then {_this select 4} else {true};
	_assign = if(count _this > 5) then {_this select 5} else {true};
	
	_leader = leader _target;	
	_task = [_player, _leader, _title, _description, _alert, _assign] call arjay_createTargetTask;
		
	[_target, _title, _task] spawn
	{
		private ["_target", "_title", "_task", "_text", "_groupCount", "_lastGroupCount"];
		_target = _this select 0;
		_title = _this select 1;
		_task = _this select 2;
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
			sleep 5;
		};
		
		[_task, true, "All targets eliminated", _title] call arjay_completeTask;
	};
	
	_task
};

/*
	Create a task to eliminate a target
*/
arjay_eliminateTarget =
{
	private ["_player", "_target", "_title", "_description", "_alert", "_assign", "_task", "_event_id"];
	
	_player = _this select 0;
	_target = _this select 1;
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_alert = if(count _this > 4) then {_this select 4} else {true};
	_assign = if(count _this > 5) then {_this select 5} else {true};
	
	_task = [_player, _target, _title, _description, _alert, _assign] call arjay_createTargetTask;
	
	[_target, _task, _title] spawn
	{
		private ["_target", "_task", "_title"];
		_target = _this select 0;
		_task = _this select 1;
		_title = _this select 2;
		
		waitUntil {sleep 5; !alive _target};
		
		[_task, true, "Target eliminated", _title] call arjay_completeTask;
	};
	
	_task
};

/*
	Create a task on a target object
*/
arjay_createTargetTask = 
{
	private ["_player", "_target", "_title", "_description", "_alert", "_assign", "_task"];
	
	_player = _this select 0;
	_target = _this select 1;
	_title = if(count _this > 2) then {_this select 2} else {""};
	_description = if(count _this > 3) then {_this select 3} else {""};
	_alert = if(count _this > 4) then {_this select 4} else {true};
	_assign = if(count _this > 5) then {_this select 5} else {true};
	
	_task = _player createSimpleTask [_title];
	_task setSimpleTaskDestination (getPos _target);
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