/*
	File: arjay_camera.sqf
	Author: ARJay
	Description: Camera handling
*/

arjay_cameraPOV = 0.700;
arjay_cameraTakenFrom = "";
arjay_cameraTakenFromView = "";


/*
	Add Camera
	Adds a camera to a targets position
	Optionally hides the target object from view
	Usage:
	params source object, hide source object, starting camera angle (height)
	myCamera1 = [camera1,true,"EYE"] call arjay_addCamera;
*/
arjay_addCamera = 
{
	private ["_camera", "_position", "_source", "_angle", "_hideSource"];

	_source = _this select 0;
	_hideSource = if(count _this > 1) then {_this select 1} else {false};
	_angle = if(count _this > 2) then {_this select 2} else {"DEFAULT"};
	
	if(_hideSource) then
	{
		hideObject _source;
	};
	
	_position = position _source;	
	_position = [_position, _angle] call arjay_setCameraAngle;

	_camera = "camera" camCreate (_position);	
	_camera camPrepareFOV arjay_cameraPOV;	
	_camera
};

/*
	Remove Camera
*/
arjay_removeCamera = 
{
	private ["_camera"];
	
	_camera = _this select 0;
	
	camDestroy _camera;
};

/*
	No Target Shot
*/
arjay_noTargetShot = 
{
	private ["_camera", "_duration"];

	_camera = _this select 0;
	_duration = if(count _this > 1) then {_this select 1} else {5};
	
	_camera camCommitPrepared _duration;
};

/*
	Static Shot
*/
arjay_staticShot = 
{
	private ["_camera", "_target", "_duration"];

	_camera = _this select 0;
	_target = _this select 1;
	_duration = if(count _this > 2) then {_this select 2} else {5};
	
	_camera camPrepareTarget _target;
	_camera camCommitPrepared _duration;
};

/*
	Switch Camera
	Switches camera to another objects perspective
	Optionally disables player control
*/
arjay_switchCamera = 
{
	private ["_target", "_type", "_disablePlayer"];

	_target = _this select 0;
	_type = if(count _this > 1) then {_this select 1} else {"FIRST_PERSON"};
	_disablePlayer = if(count _this > 2) then {_this select 2} else {false};
	
	if(_disablePlayer) then
	{
		disableUserInput true;
	};
	
	arjay_cameraTakenFrom = cameraOn;
	arjay_cameraTakenFromView = cameraView;
	
	switch(_type) do
	{
		case "FIRST_PERSON":
		{
			_target switchCamera "INTERNAL";
		};	
		case "OPTICS":
		{
			_target switchCamera "GUNNER";
		};
		case "THIRD_PERSON":
		{
			_target switchCamera "EXTERNAL";
		};
		case "FIRST_PERSON_REAL":
		{
			_target switchCamera "VIEW";
		};
	};	
	
};

/*
	Revert Camera
	Reverts camera to original object
	To be called after switch camera shot completed
*/
arjay_revertCamera = 
{	
	private ["_enablePlayer"];
	
	_enablePlayer = _this select 0;

	if(_enablePlayer) then
	{
		disableUserInput false;
	};
	
	arjay_cameraTakenFrom switchCamera arjay_cameraTakenFromView;
};

/*
	Pan Shot
	Pans a given camera between to targets you supply
	Optionally hides the target objects from view
*/
arjay_panShot = 
{
	private ["_camera", "_target1", "_target2", "_hideTargets", "_duration"];
	
	_camera = _this select 0;
	_target1 = _this select 1;
	_target2 = _this select 2;
	_duration = if(count _this > 3) then {_this select 3} else {5};
	_hideTargets = if(count _this > 4) then {_this select 4} else {false};
	
	if(_hideTargets) then
	{
		hideObject _target1;
		hideObject _target2;
	};
	
	_camera camPrepareTarget _target1;
	_camera camCommitPrepared _duration;
	
	_camera camPrepareTarget _target2;
	_camera camCommitPrepared _duration;
};

/*
	FlyIn Shot
*/
arjay_flyInShot = 
{
	private ["_camera", "_target", "_hideTarget", "_duration"];
	
	_camera = _this select 0;
	_target = _this select 1;
	_duration = if(count _this > 3) then {_this select 3} else {5};
	_hideTarget = if(count _this > 4) then {_this select 4} else {false};
	
	if(_hideTarget) then
	{
		hideObject _target;
	};
	
	_camera camPrepareTarget _target;
	_camera camPreparePos [(getpos _target select 0)- 40,(getpos _target select 1)+40, 12];
	_camera camCommitPrepared 0;
	_camera camPreparePos [(getpos _target select 0)- 3,(getpos _target select 1)+3, 2];
	_camera camCommitPrepared _duration;
};

/*
	Chase Shot
*/
arjay_chaseShot = 
{
	private ["_camera", "_target", "_hideTarget", "_duration", "_i"];
	
	_camera = _this select 0;
	_target = _this select 1;
	_duration = if(count _this > 3) then {_this select 3} else {5};
	_hideTarget = if(count _this > 4) then {_this select 4} else {false};
	
	if(_hideTarget) then
	{
		hideObject _target;
	};
	
	_i = 0;
	while {_i < _duration / 0.1} do
	{
		_i = _i + 1;
		_camera attachTo [_target, [0,-10,2]];
		_camera camCommitPrepared 0;
		sleep 0.1;
	};
};

/*
	Chase Side Shot
*/
arjay_chaseSideShot = 
{
	private ["_camera", "_target", "_hideTarget", "_duration", "_i"];
	
	_camera = _this select 0;
	_target = _this select 1;
	_duration = if(count _this > 3) then {_this select 3} else {5};
	_hideTarget = if(count _this > 4) then {_this select 4} else {false};
	
	if(_hideTarget) then
	{
		hideObject _target;
	};
	
	_i = 0;
	while {_i < _duration / 0.1} do
	{
		_i = _i + 1;
		_camera attachTo [_target, [-5,0,2]];
		_camera camPrepareTarget _target;
		_camera camCommitPrepared 0;
		sleep 0.1;
	};
};

/*
	Chase Angle Shot
*/
arjay_chaseAngleShot = 
{
	private ["_camera", "_target", "_hideTarget", "_duration", "_i"];
	
	_camera = _this select 0;
	_target = _this select 1;
	_duration = if(count _this > 3) then {_this select 3} else {5};
	_hideTarget = if(count _this > 4) then {_this select 4} else {false};
	
	if(_hideTarget) then
	{
		hideObject _target;
	};
	
	_i = 0;
	while {_i < _duration / 0.1} do
	{
		_i = _i + 1;
		_camera camPrepareTarget _target;
		_camera attachTo [_target, [-5,-5,2]];
		_camera camCommitPrepared 0;
		sleep 0.1;
	};
};

/*
	Chase Wheel Shot
*/
arjay_chaseWheelShot = 
{
	private ["_camera", "_target", "_hideTarget", "_duration", "_i"];
	
	_camera = _this select 0;
	_target = _this select 1;
	_duration = if(count _this > 3) then {_this select 3} else {5};
	_hideTarget = if(count _this > 4) then {_this select 4} else {false};
	
	if(_hideTarget) then
	{
		hideObject _target;
	};
	
	_i = 0;
	while {_i < _duration / 0.1} do
	{
		_i = _i + 1;
		_camera attachTo [_target, [-1.4,1,-1]];
		_camera camCommitPrepared 0;
		sleep 0.1;
	};
};

/*
	Zoom Shot
*/
arjay_zoomShot = 
{
	private ["_camera", "_target", "_hideTarget", "_duration"];
	
	_camera = _this select 0;
	_target = _this select 1;
	_duration = if(count _this > 3) then {_this select 3} else {5};
	_hideTarget = if(count _this > 4) then {_this select 4} else {false};
	
	if(_hideTarget) then
	{
		hideObject _target;
	};
	
	_camera camPrepareTarget _target;
	_camera camPreparePos [(getpos _target select 0)- 30,(getpos _target select 1)+20, 2];
	_camera camCommitPrepared 0;
	_camera camPrepareFOV 0.100;
	_camera camCommitPrepared _duration;
	sleep _duration;
	_camera camPrepareFOV arjay_cameraPOV;
};

/*
	Raise Camera 
*/
arjay_raiseCamera = 
{
	private ["_camera", "_height", "_duration", "_position", "_Y"];
	
	_camera = _this select 0;
	_height = _this select 1;
	_duration = if(count _this > 2) then {_this select 2} else {5};
	
	_position = position _camera;		
	_Y = _position select 2;
	_position set [2,_Y+_height];
	
	_camera camPreparePos _position;
	_camera camCommitPrepared _duration;
};

/*
	Lower Camera 
*/
arjay_lowerCamera = 
{
	private ["_camera", "_height", "_duration", "_position", "_Y"];
	
	_camera = _this select 0;
	_height = _this select 1;
	_duration = if(count _this > 2) then {_this select 2} else {5};
	
	_position = position _camera;		
	_Y = _position select 2;
	_position set [2,_Y-_height];
	
	_camera camPreparePos _position;
	_camera camCommitPrepared _duration;
};

/*
	Move Camera 
*/
arjay_moveCamera = 
{
	private ["_camera", "_target", "_angle", "_duration", "_position", "_hideTargets"];
	
	_camera = _this select 0;
	_target = _this select 1;
	_angle = if(count _this > 2) then {_this select 2} else {"DEFAULT"};
	_duration = if(count _this > 3) then {_this select 3} else {5};
	_hideTargets = if(count _this > 4) then {_this select 4} else {false};
	
	if(_hideTargets) then
	{
		hideObject _target;
	};
	
	_position = position _target;	
	_position = [_position, _angle] call arjay_setCameraAngle;
	
	_camera camPreparePos _position;
	_camera camCommitPrepared _duration;
};

/*
	Start Shooting
*/
arjay_startCinematic = 
{
	private ["_camera", "_cinemaBorder"];
	
	_camera = _this select 0;
	_cinemaBorder = if(count _this > 1) then {_this select 1} else {false};	
		
	if(_cinemaBorder) then 
	{
		showCinemaBorder true;
	};
	
	["",1,0,1] call arjay_cut;
	
	sleep 1;
	
	_camera cameraEffect ["Internal", "Back"];	
};

/*
	Stop Shooting
*/
arjay_stopCinematic = 
{
	private ["_camera"];
	
	_camera = _this select 0;
	
	["",1,0,1] call arjay_cut;
	
	sleep 1;
	
	_camera cameraEffect ["Terminate", "Back"];
};

/*
	Set Camera Angle
*/
arjay_setCameraAngle = 
{
	private ["_position", "_angle", "_Y"];
	
	_position = _this select 0;
	_angle = _this select 1;
	
	switch(_angle) do 
	{
		case "DEFAULT":
			{
			
			};		
		case "LOW":
			{
				_Y = _position select 2;
				_position set [2,_Y+1];
			};
		case "EYE":
			{
				_Y = _position select 2;
				_position set [2,_Y+1.3];
			};
		case "HIGH":
			{
				_Y = _position select 2;
				_position set [2,_Y+2];
			};
		case "BIRDS_EYE":
			{
				_Y = _position select 2;
				_position set [2,_Y+20];
			};
		case "UAV":
			{
				_Y = _position select 2;
				_position set [2,_Y+100];
			};
		case "SATELITE":
			{
				_Y = _position select 2;
				_position set [2,_Y+500];
			};
		
	};
	
	_position
};

/*
	Create Live Feed
*/
arjay_createLiveFeedCamera = 
{
	private ["_viewer", "_camera", "_target", "_position", "_source", "_angle", "_hideSource"];

	_viewer = _this select 0;
	_source = _this select 1;
	_target = _this select 2;
	_hideSource = if(count _this > 3) then {_this select 3} else {false};
	_angle = if(count _this > 4) then {_this select 4} else {"DEFAULT"};
	
	if(_hideSource) then
	{
		hideObject _source;
	};
	
	_position = position _source;	
	_position = [_position, _angle] call arjay_setCameraAngle;

	[_position, _target, player] call BIS_fnc_liveFeed;
	BIS_liveFeed camPrepareFOV arjay_cameraPOV;	
	BIS_liveFeed
};

/*
	Live Feed Effect
*/
arjay_createLiveFeedEffect = 
{
	private ["_type"];
	
	_type = _this select 0;
	
	switch(_type) do
	{			
		case "NIGHT_VISION":
			{
				1 call BIS_fnc_liveFeedEffects;
			};
		case "THERMAL":
			{
				2 call BIS_fnc_liveFeedEffects;
			};
		case "DEFAULT":
			{	
				[] call BIS_fnc_liveFeedEffects;
			};
	};	
};

/*
	Remove Live Feed
*/
arjay_removeLiveFeedCamera = 
{
	[] call BIS_fnc_liveFeedTerminate;
};