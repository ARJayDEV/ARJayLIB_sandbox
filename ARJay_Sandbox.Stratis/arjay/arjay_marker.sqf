/*
	File: arjay_marker.sqf
	Author: ARJay
	Description: Marker handling. Includes tracking for moving markers locked to an target object.
	Tracking is only activated when a marker with follow = true is added.
	Props: KNDR_unit_markers (zemek kondor)
	
	Shapes
	"ICON"
	"RECTANGLE"
	"ELLIPSE"
	
	Colours
	"ColorBlack"
	"ColorRed"
	"ColorRedAlpha"
	"ColorGreen"
	"ColorGreenAlpha"
	"ColorBlue"
	"ColorYellow"
	"ColorOrange"
	"ColorWhite"
	
	Brushes
	"Solid"
	"Horizontal"
	"Vertical"
	"Grid"
	"FDiagonal"
	"BDiagonal"
	"DiagGrid"
	"Cross"
	"Border"
	"SolidBorder"	
*/

arjay_markerTrackingTick = 4;
arjay_markerTargets = [];
arjay_markers = [];
arjay_markerFollow = [];
arjay_markerIsTracking = false;
arjay_markerCount = 0;

/*
	Add a marker to an target
*/
arjay_addMarker = 
{
	private ["_name", "_target", "_type", "_follow", "_text", "_size", "_alpha", "_marker"];

	_target = _this select 0;
	_type = if(count _this > 1) then {_this select 1} else {"DEFAULT"};
	_follow = if(count _this > 2) then {_this select 2} else {false};
	_text = if(count _this > 3) then {_this select 3} else {"false"};
	_size = if(count _this > 4) then {_this select 4} else {[100,100]};
	_alpha = if(count _this > 5) then {_this select 5} else {1};
	
	_name = format["arjay_marker%1", arjay_markerCount];
	arjay_markerCount = arjay_markerCount + 1;

	_marker = createMarkerLocal [_name, position _target];
	if(_text != "false") then 
	{
		_marker setMarkerTextLocal _text;
	};
	_marker setMarkerSizeLocal _size;
	_marker setMarkerAlphaLocal _alpha;
	
	if(_follow) then 
	{
		if(!arjay_markerIsTracking) then 
		{
			arjay_markerIsTracking = true;
			[] spawn arjay_trackMarkers;
		};
	};

	switch(_type) do
	{
		case "DEFAULT":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_objective";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "FLAG":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_flag";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "DESTROY":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_destroy";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "START":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_start";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "END":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_end";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "PICKUP":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_pickup";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "WARNING":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_warning";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "UNKNOWN":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_unknown";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "DOT":
			{			
				_marker setMarkerSizeLocal [1,1];
				_marker setMarkerTypeLocal "hd_dot";	
				_marker setMarkerColorLocal "ColorOrange";
			};
		case "WARNING_BOX":
			{			
				_marker setMarkerShapeLocal "RECTANGLE";
				_marker setMarkerBrushLocal "DiagGrid";			
				_marker setMarkerColorLocal "ColorRed";
			};
		case "WARNING_ZONE":
			{			
				_marker setMarkerShapeLocal "ELLIPSE";
				_marker setMarkerBrushLocal "DiagGrid";			
				_marker setMarkerColorLocal "ColorRed";
			};
		case "INFO_BOX":
			{			
				_marker setMarkerShapeLocal "RECTANGLE";
				_marker setMarkerBrushLocal "DiagGrid";			
				_marker setMarkerColorLocal "ColorBlue";
			};	
		case "INFO_ZONE":
			{			
				_marker setMarkerShapeLocal "ELLIPSE";
				_marker setMarkerBrushLocal "DiagGrid";			
				_marker setMarkerColorLocal "ColorBlue";
			};
	};
	
	arjay_markerTargets set [count arjay_markerTargets,_target];
	arjay_markers set [count arjay_markers,_marker];
	arjay_markerFollow set [count arjay_markerFollow,_follow];
};

/*
	Remove a marker
*/
arjay_removeMarker =
{
	private ["_marker", "_target", "_follow"];
	
	_target = arjay_markerTargets select (_this select 0);
	_marker = arjay_markers select (_this select 0);
	_follow = arjay_markerFollow select (_this select 0);

	arjay_markerTargets = arjay_markerTargets - [_target];
	arjay_markers = arjay_markers - [_marker];
	arjay_markerFollow = arjay_markerFollow - [_follow];

	deleteMarkerLocal _marker;
};

/*
	Tracking loop
*/
arjay_trackMarkers = 
{
	while {arjay_markerIsTracking} do
	{
		[] call arjay_updateMarkers;
		sleep arjay_markerTrackingTick;
	};
};

/*
	Tracking update position
*/
arjay_updateMarkers = 
{
	private ["_i", "_target", "_marker"];
	
	for "_i" from ((count arjay_markerTargets) - 1) to 0 step -1 do
	{
		_target = arjay_markerTargets select _i;
		_marker = arjay_markers select _i;
		_follow = arjay_markerFollow select _i;
		
		if(_follow) then {
			if ([_target] call arjay_checkRemove) then
			{
				[_i] call arjay_removeMarker;
			}
			else
			{
				_marker setMarkerPosLocal (getPos _target);
				_marker setMarkerDirLocal (getDir _target);
			};
		};
	};
};

/*
	Tracking targets for removal
*/
arjay_checkRemove = 
{
	private ["_flag"];
	_flag = false;
	if (isNull (_this select 0)) then
	{
		_flag = true;
	}
	else
	{
		if (not alive (_this select 0)) then
		{
			_flag = true;
		};
	};
	_flag
};