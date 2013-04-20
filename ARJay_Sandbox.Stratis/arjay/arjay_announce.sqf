/*
	File: arjay_announce.sqf
	Author: ARJay
	Description: UI announcements 
*/

/*
	Add Cut
	Title Effects
	"PLAIN",
	"PLAIN DOWN",
	"BLACK",
	"BLACK FADED",
	"BLACK OUT",
	"BLACK IN",
	"WHITE OUT",
	"WHITE IN"
*/
arjay_cut = 
{
	private ["_text", "_in", "_hold", "_out"];

	_text = _this select 0;
	_in = if(count _this > 1) then {_this select 1} else {1};
	_hold = if(count _this > 2) then {_this select 2} else {1};
	_out = if(count _this > 3) then {_this select 3} else {1};
		
	2000 cutText [_text, "BLACK", _in];
	sleep _hold;
	2000 cutFadeOut _out;
};
	
/*
	Add Title
*/
arjay_title = 
{
	private ["_text", "_in", "_hold", "_out", "_type"];

	_text = _this select 0;
	_in = if(count _this > 1) then {_this select 1} else {1};
	_hold = if(count _this > 2) then {_this select 2} else {1};
	_out = if(count _this > 3) then {_this select 3} else {1};
	_type = if(count _this > 4) then {_this select 4} else {"PLAIN"};

	titleText [_text, _type, _in];
	sleep _hold;
	titleFadeOut _out;
};

/*
	Add Info
*/
arjay_info = 
{
	private ["_text"];
	
	_text = _this select 0;	
	[_text] spawn BIS_fnc_infoText;
};

/*
	Add Credits
	This is buggy, works if you trigger BIS_fnc_infoText first, probably a bug
*/
arjay_credits = 
{
	private ["_target", "_text"];
	
	_target = _this select 0;
	_text = _this select 1;	
	_text = [_text] call arjay_structuredText;
	
	[" "] spawn BIS_fnc_infoText;
	[_text,getPos _target,20,0] spawn bis_fnc_3Dcredits;
};

/*
	Add Dynamic Text	
*/
arjay_dynamicText = 
{
	private ["_text", "_type", "_size", "_font", "_colour"];

	_text = _this select 0;	
	_type = if(count _this > 1) then {_this select 1} else {"CENTER_UP"};		
	_size = if(count _this > 2) then {_this select 2} else {1};
	_font = if(count _this > 3) then {_this select 3} else {"PuristaLight"};
	_colour = if(count _this > 4) then {_this select 4} else {"#ffffff"};
	
	switch(_type) do
	{
		case "CENTER_UP":
			{		
				hint _type;
				_text = [_text, _size, _font] call arjay_structuredText;
				//text, x, y, duration, fade-in, delta y
				[_text, 0.02, 0.3, 5, 2, -2] spawn bis_fnc_dynamicText;
			};
		case "BOTTOM_DOWN":
			{	
				hint _type;
				_text = [_text, _size, _font] call arjay_structuredText;
				[_text, 0, 1, 5, 1, 1] spawn bis_fnc_dynamicText;
			};
		case "BOTTOM_LEFT_DOWN":
			{	
				hint _type;
				_text = [_text, _size, _font] call arjay_structuredText;
				[_text, -(safezoneW-1.03)/2, 1, 5, 1, 1] spawn bis_fnc_dynamicText;
			};
	};	
};

/*
	Add AAN News overlay
*/
arjay_addAANNews = 
{
	private ["_titleStr", "_scrollStr", "_title", "_subtitle", "_scroll"];

	_title = _this select 0;
	_subtitle = _this select 1;
	_scroll = _this select 2;

	// Assemble the text from passed vars
	_titleStr = format["<t size='2.3'>%1</t><br /><t size='0.6'>%2</t>",_title,_subtitle];
	_scrollStr = format["%1",_scroll];
	_title = parseText _titleStr; 
	_scroll = parseText _scrollStr; 

	// Spawn the AAN overlay
	[_title,_scroll] spawn BIS_fnc_AAN;
};

/*
	Format
	http://community.bistudio.com/wiki/Structured_Text
	
	ARMA3 Font Families (CfgFontFamilies)
	EtelkaMonospaceProBold
	EtelkaNarrowMediumPro
	LucidaConsoleB
	PuristaBold
	PuristaLight
	PuristaMedium
	PuristaSemibold
	TahomaB
*/
arjay_structuredText = 
{
	private ["_text", "_size", "_font", "_colour", "_shadow", "_shadowColour"];
	
	_text = _this select 0;
	_size = if(count _this > 1) then {_this select 1} else {1};
	_font = if(count _this > 2) then {_this select 2} else {"PuristaLight"};
	_colour = if(count _this > 3) then {_this select 3} else {"#ffffff"};
	_shadow = if(count _this > 4) then {_this select 4} else {0};
	_shadowColour = if(count _this > 5) then {_this select 5} else {"#000000"};
	
	if(_shadow > 0) then
	{
		_text = format["<t size='%2' font='%3' color='%4' shadow='%5' shadowColor='%6'>%1</t>",_text,_size,_font,_colour,_shadow,_shadowColour];
	}
	else
	{
		_text = format["<t size='%2' font='%3' color='%4'>%1</t>",_text,_size,_font,_colour];
	};
	
	_text
};