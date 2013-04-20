/*
	File: arjay_effect.sqf
	Author: ARJay
	Description: Effects
*/

arjay_cameraPOV = 0.700;
arjay_effects = [];

/*
	Add Effect
*/
arjay_applyPostProcessEffect = 
{		
	private ["_effect", "_type"];
	
	_type = _this select 0;
	
	switch(_type) do
	{			
		case "KODAK":
			{
				_effect = ppEffectCreate ["ColorCorrections", 1999];
				_effect ppEffectAdjust[ 0.67, 1, 0.01, [0.03, 0.1, 0, -0.34],[1.8, 1.8, 0.3, 0.7],[0.2, 0.59, 0.11, 0]];				
			};
		case "MONOCHROME":
			{
				_effect = ppEffectCreate ["ColorCorrections", 1999];
				_effect ppEffectAdjust [0.5, 1, 0, [1, 1, 1, 0], [1, 1, 1, 0.0], [1, 1, 1, 1.0]];				
			};
		case "FILM_GRAIN":
			{		
				_effect = ppEffectCreate ["filmGrain", 2001];	
				_effect ppEffectAdjust [0.1, 1, 1, 0, 1];
			};
		case "DESATURATED":
			{	
				_effect = ppEffectCreate ["colorCorrections", 2002];
				_effect ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [0.8, 0.8, 0.8, 0.65], [1, 1, 1, 1.0]];
			};
	};	
	
	_effect ppEffectEnable true;
	_effect ppEffectCommit 0;
	arjay_effects set [count arjay_effects,_effect];	
};

/*
	Remove all effects
*/
arjay_removePostProcessEffects = 
{		
	ppEffectDestroy arjay_effects;
};