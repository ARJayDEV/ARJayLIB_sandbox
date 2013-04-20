/*
	File: arjay_environment.sqf
	Author: ARJay
	Description: World environment handling
	props ruebe for sunrise / sunset calculations for given day!
*/

/*
	Set environment preset
	preset:
	[["SUNRISE"],["STORMY"]]
*/
arjay_setEnvironment = 
{
	private ["_preset", "_timePreset", "_weatherPreset", "_debug"];
	
	_preset = _this select 0;
	_debug = if(count _this > 1) then {_this select 1} else {true};
	
	_timePreset = _preset select 0;
	_weatherPreset = _preset select 1;	
	
	if(_debug) then { call arjay_inspectEnvironment; };
	
	_timePreset call arjay_setTime;
	_weatherPreset call arjay_setWeather;
	
	if(_debug) then { call arjay_inspectEnvironment; };
};

/*
	Set time preset
*/
arjay_setTime = 
{
	private ["_preset", "_now", "_sunRise", "_sunSet"];
	
	_preset = _this select 0;
	_now = date;
		
	switch(_preset) do
	{			
		case "DEEP_NIGHT":
			{				
				setDate [_now select 0, _now select 1, _now select 2, 2, 00];
			};
		case "SUNRISE":
			{
				_sunRise = [_now select 0, _now select 1, _now select 2] call arjay_getSunriseSunset select 0;
				setDate [_now select 0, _now select 1, _now select 2, _sunRise select 0, _sunRise select 1];
			};
		case "MID_MORNING":
			{				
				setDate [_now select 0, _now select 1, _now select 2, 10, 30];
			};
		case "MIDDAY":
			{				
				setDate [_now select 0, _now select 1, _now select 2, 12, 00];
			};
		case "MID_AFTERNOON":
			{				
				setDate [_now select 0, _now select 1, _now select 2, 15, 30];
			};
		case "SUNSET":
			{
				_sunSet = [_now select 0, _now select 1, _now select 2] call arjay_getSunriseSunset select 1;
				setDate [_now select 0, _now select 1, _now select 2, _sunSet select 0, _sunSet select 1];
			};
		case "MID_EVENING":
			{				
				setDate [_now select 0, _now select 1, _now select 2, 21, 30];
			};
		case "MIDNIGHT":
			{				
				setDate [_now select 0, _now select 1, _now select 2, 23, 59];
			};
	};	
};

/*
	Set day preset
*/
arjay_setDay = 
{
	private ["_preset", "_now"];
	
	_preset = _this select 0;
	_now = date;
	
	call arjay_inspectEnvironment;
		
	switch(_preset) do
	{			
		case "FULL_MOON":
			{				
				setDate [2035, 9, 9, 1, 15];
			};
		case "NO_MOON":
			{				
				setDate [2035, 9, 24, 1, 15];
			};
		case "SPRING":
			{				
				setDate [2035, 4, 15, _now select 3, _now select 4];
			};
		case "SUMMER":
			{				
				setDate [2035, 7, 15, _now select 3, _now select 4];
			};
		case "AUTUMN":
			{				
				setDate [2035, 10, 15, _now select 3, _now select 4];
			};
		case "WINTER":
			{				
				setDate [2035, 12, 24, _now select 3, _now select 4];	
			};
	};	
	
	call arjay_inspectEnvironment;
};

/*
	Set weather
	Currently weathy is iffy in the alpha revise at beta.
*/
arjay_setWeather = 
{
	private ["_preset", "_delay", "_now"];
	
	_preset = _this select 0;
	_delay = if(count _this > 1) then {_this select 1} else {30};
	_now = date;
		
	switch(_preset) do
	{			
		case "STORMY":
			{
				_delay setOvercast 1;
				_delay setGusts 1;
				_delay setWindForce 1;
				_delay setWindStr 1;
				_delay setLightnings 1;
				
				[_now] spawn {
					_now = _this select 0;
					skipTime 4;
					setDate [_now select 0, _now select 1, _now select 2, _now select 3, _now select 4];
					call arjay_inspectEnvironment;
				};			
			};
		case "CLEAR":
			{
				_delay setOvercast 0;
				_delay setGusts 0;
				_delay setWindForce 0;
				_delay setWindStr 0;
				_delay setLightnings 0;
				
				[_now] spawn {
					_now = _this select 0;
					skipTime 4;
					setDate [_now select 0, _now select 1, _now select 2, _now select 3, _now select 4];
					call arjay_inspectEnvironment;
				};			
			};
		case "OVERCAST":
			{			
				_delay setOvercast 0.5;
				_delay setGusts 0.5;
				_delay setWindForce 0.5;
				_delay setWindStr 0.5;
				_delay setLightnings 0.5;
				
				[_now] spawn {
					_now = _this select 0;
					skipTime 4;
					setDate [_now select 0, _now select 1, _now select 2, _now select 3, _now select 4];
					call arjay_inspectEnvironment;
				};			
			};
	};	
};

/*
	Get sunrise / sunset times
*/
arjay_getSunriseSunset = 
{
	private ["_year", "_month", "_day", "_zenith", "_latitude", "_longitude"];

	_year = _this select 0;
	_month = _this select 1;
	_day = _this select 2;

	/*
	   zenith:
	   - offical = 90 degrees
	   - civil = 96 degrees
	   - nautical = 102 degrees
	   - astronomical = 108 degrees
	*/
	_zenith = 90; 

	_latitude = getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude") * -1;
	_longitude = getNumber(configFile >> "CfgWorlds" >> worldName >> "longitude");

	/*
	   CALCULATION
	*/

	private ["_n1", "_n2", "_n3", "_n", "_lngHour", "_times"];

	// day of the year
	_n1 = floor (275 * _month / 9);
	_n2 = floor ((_month + 9) / 12);
	_n3 = 1 + floor ((_year - (4 * (floor (_year / 4))) + 2) / 3);
	_n = _n1 - (_n2 * _n3) + _day - 30;

	// convert longitude to hour value and calculate an approximate time
	_lngHour = _longitude / 15;

	_times = [];

	{
	   private [
		  "_t", "_m", "_l", "_ra", "_lQuadrant", "_raQuadrant", 
		  "_sinDec", "_cosDec", "_cosH", "_h", "_ut", "_local", "_localH"
	   ];
	   
	   if (_x) then
	   {
		  _t = (_n + ((6 - _lngHour) / 24)); // rising time
	   } else
	   {
		  _t = (_n + ((18 - _lngHour) / 24)); // setting time
	   };

	   // sun's mean anomaly
	   _m = (0.9856 * _t) - 3.289;

	   // sun's true longitude
	   _l = _m + (1.916 * (sin _m)) + (0.020 * (sin (2 * _m))) + 282.634;

	   while {(_l < 0)} do { _l = _l + 360; };
	   _l = _l % 360;

	   // sun's right ascension
	   _ra = atan (0.91764 * (tan _l));

	   while {(_ra < 0)} do { _ra = _ra + 360; };
	   _ra = _ra % 360;

	   // right ascension value needs to be in the same quadrant as L
	   _lQuadrant = (floor (_l / 90)) * 90;
	   _raQuadrant = (floor (_ra / 90)) * 90;
	   _ra = _ra + (_lQuadrant - _raQuadrant);

	   // right ascension value needs to be converted into hours
	   _ra = _ra / 15;

	   // sun's declination
	   _sinDec = 0.39782 * (sin _l);
	   _cosDec = cos (asin _sinDec);

	   // sun's local hour angle
	   _cosH = ((cos _zenith) - (_sinDec * (sin _latitude))) / (_cosDec * (cos _latitude));

	   /*
	   if (_cosH > 1) then
	   {
		  // the sun never rises on this location (on the specified date)
	   };

	   if (_cosH < -1) then
	   {
		  // the sun never sets on this location (on the specified date)
	   };
	   */

	   // finish calculating H and convert into hours
	   if (_x) then
	   {
		  _h = 360 - (acos _cosH); // rising time
	   } else
	   {
		  _h = acos _cosH; // setting time
	   };
	   
	   _h = _h / 15;
	   
	   // local mean time of rising/setting
	   _t = _h + _ra - (0.06571 * _t) - 6.622;
	   
	   // adjust back to UTC
	   _ut = _t - _lngHour;
	   
	   while {(_ut < 0)} do { _ut = _ut + 24; };
	   _ut = _ut % 24;
	   
	   // plus ~local time
	   _local = _ut + (floor (_longitude / 15));
	   
	   _localH = floor _local;
	   
	   // scalar to hours and minutes
	   _times set [
		  (count _times), 
		  [
			 _localH,
			 (floor ((_local - _localH) * 60))
		  ]
	   ];

	} forEach [
	   true, // rising time
	   false // setting time
	];

	// return
	_times
};