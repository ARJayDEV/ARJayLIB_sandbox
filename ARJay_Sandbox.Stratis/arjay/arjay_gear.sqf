/*
	File: arjay_gear.sqf
	Author: ARJay
	Description: ARMA3 Gear Handling
	Props: Tonics ammo box script http://www.armaholic.com/forums.php?m=posts&q=20825
*/

arjay_genericItems = ["ItemWatch","ItemCompass","ItemGPS","ItemRadio","ItemMap"];
arjay_magazineLimit = 2;

/*
	Set Loadout
*/
arjay_setLoadout = 
{
	private ["_target", "_preset", "_strip"];
	_target = _this select 0;
	_preset = _this select 1;
	_strip = if(count _this > 2) then {_this select 2} else {true};
	
	if(_strip) then
	{
	[_target] call arjay_stripLoadout;	
	};
	[_target, _preset] call arjay_setUniformLoadout;
	[_target, _preset] call arjay_setPackLoadout;
	[_target, _preset] call arjay_setWeaponLoadout;	
	[_target, _preset] call arjay_setItemLoadout;
};

/*
	Set Weapon Loadout
*/
arjay_setWeaponLoadout = 
{
	private ["_target", "_preset", "_magazines", "_weapons", "_primaryAccessories", "_handgunAccessories"];
	_target = _this select 0;
	_preset = _this select 1;
	
	switch(_preset) do
	{
		case "B_DIVER":
		{
			_magazines = ["20Rnd_556x45_UW_mag","30Rnd_556x45_Stanag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_SDAR_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_HELI_PILOT":
		{
			_magazines = ["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_MXC_Holo_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_MARKSMAN":
		{
			_magazines = ["20Rnd_762x45_Mag","16Rnd_9x21_Mag"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_MXM_ARCO_point_F","hgun_P07_F","HandGrenade","SmokeShell"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_RIFLEMAN":
		{
			_magazines = ["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_MX_Hamr_point_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_AUTO_RIFLEMAN":
		{
			_magazines = ["100Rnd_65x39_caseless_mag_Tracer","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_MX_SW_Hamr_point_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_LEADER":
		{
			_magazines = ["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","16Rnd_9x21_Mag","HandGrenade","SmokeShell","1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeBlue_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell", "1Rnd_SmokeOrange_Grenade_shell", "1Rnd_SmokePurple_Grenade_shell", "1Rnd_SmokeRed_Grenade_shell", "1Rnd_SmokeYellow_Grenade_shell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_MX_GL_Hamr_point_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_MEDIC":
		{
			_magazines = ["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_MX_ACO_point_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_SPECIALIST_EXPLOSIVE":
		{
			_magazines = ["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_MXC_ACO_flash_grip_mzls_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_SPECIALIST_REPAIR":
		{
			_magazines = ["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_MXC_ACO_flash_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_DIVER":
		{
			_magazines = ["20Rnd_556x45_UW_mag","30Rnd_556x45_Stanag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_SDAR_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_HELI_PILOT":
		{
			_magazines = ["30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_Khaybar_C_Holo_F","hgun_P07_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_MARKSMAN":
		{
			_magazines = ["20Rnd_762x45_Mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","srifle_EBR_ARCO_point_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_RIFLEMAN":
		{
			_magazines = ["30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_Khaybar_ARCO_point_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_AUTO_RIFLEMAN":
		{
			_magazines = ["200Rnd_65x39_cased_Box","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","LMG_Mk200_ARCO_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_LEADER":
		{
			_magazines = ["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","16Rnd_9x21_Mag","HandGrenade","SmokeShell","1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeBlue_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell", "1Rnd_SmokeOrange_Grenade_shell", "1Rnd_SmokePurple_Grenade_shell", "1Rnd_SmokeRed_Grenade_shell", "1Rnd_SmokeYellow_Grenade_shell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_Khaybar_GL_ACOg_point_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_MEDIC":
		{
			_magazines = ["30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_Khaybar_C_Holo_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_SPECIALIST_EXPLOSIVE":
		{
			_magazines = ["30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_Khaybar_C_Holo_point_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "O_SPECIALIST_REPAIR":
		{
			_magazines = ["30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_Khaybar_C_Holo_point_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "GANGSTER1":
		{
			_magazines = ["30Rnd_65x39_case_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_TRG20_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "GANGSTER2":
		{
			_magazines = ["30Rnd_65x39_case_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["Binocular","arifle_TRG21_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "GANGSTER3":
		{
			_magazines = ["16Rnd_9x21_Mag"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "GANGSTER4":
		{
			_magazines = ["16Rnd_9x21_Mag"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["arifle_Khaybar_F","hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		case "B_SPEC_OPS":
		{
			_magazines = ["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["arifle_MX_Hamr_point_F","hgun_Rook40_snds_F"];
			[_target,_weapons] call arjay_addWeapons;
			_primaryAccessories = ["acc_pointer_IR","muzzle_snds_H"];
			[_target,_primaryAccessories] call arjay_addPrimaryItems;
			_handgunAccessories = ["muzzle_snds_L"];
			[_target,_handgunAccessories] call arjay_addHandgunItems;
		};
		case "B_SPEC_OPS2":
		{
			_magazines = ["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["arifle_MXC_Holo_point_snds_F","hgun_Rook40_snds_F"];
			[_target,_weapons] call arjay_addWeapons;
			_primaryAccessories = ["acc_pointer_IR","muzzle_snds_H"];
			[_target,_primaryAccessories] call arjay_addPrimaryItems;
			_handgunAccessories = ["muzzle_snds_L"];
			[_target,_handgunAccessories] call arjay_addHandgunItems;
		};
		case "ROGUE1":
		{
			_magazines = ["16Rnd_9x21_Mag"];
			[_target,_magazines] call arjay_addMagazines;
			_weapons = ["hgun_Rook40_F"];
			[_target,_weapons] call arjay_addWeapons;
		};
		default
		{
		
		};
	};
};

/*
	Set Uniform Loadout
*/
arjay_setUniformLoadout = 
{
	private ["_target", "_preset", "_items"];
	_target = _this select 0;
	_preset = _this select 1;
	
	switch(_preset) do
	{
		case "B_DIVER":
		{
			_target addUniform "U_B_Wetsuit";
			_target addVest "V_RebreatherB";			
		};
		case "B_HELI_PILOT":
		{
			_target addUniform "U_B_HeliPilotCoveralls";
			_target addVest "V_TacVest_oli";
			_target addHeadgear	"H_PilotHelmetHeli_B";			
		};
		case "B_MARKSMAN":
		{
			_target addUniform "U_B_CombatUniform_mcam";
			_target addVest "V_ChestrigB_rgr";
			_target addHeadgear	"H_HelmetB";			
		};
		case "B_RIFLEMAN":
		{
			_target addUniform "U_B_CombatUniform_mcam";
			_target addVest "V_PlateCarrier2_rgr";
			_target addHeadgear	"H_HelmetB";
		};
		case "B_AUTO_RIFLEMAN":
		{
			_target addUniform "U_B_CombatUniform_mcam_tshirt";
			_target addVest "V_PlateCarrier1_rgr";
			_target addHeadgear	"H_HelmetB";			
		};
		case "B_LEADER":
		{
			_target addUniform "U_B_CombatUniform_mcam_vest";
			_target addVest "V_PlateCarrierGL_rgr";
			_target addHeadgear	"H_HelmetB";			
		};
		case "B_MEDIC":
		{
			_target addUniform "U_B_CombatUniform_mcam_tshirt";
			_target addVest "V_PlateCarrier2_rgr";
			_target addHeadgear	"H_HelmetB";			
		};
		case "B_SPECIALIST_EXPLOSIVE":
		{
			_target addUniform "U_B_CombatUniform_mcam";
			_target addVest "V_ChestrigB_rgr";
			_target addHeadgear	"H_HelmetB";			
		};		
		case "B_SPECIALIST_REPAIR":
		{
			_target addUniform "U_B_CombatUniform_mcam";
			_target addVest "V_ChestrigB_rgr";
			_target addHeadgear	"H_HelmetB";			
		};
		case "O_DIVER":
		{
			_target addUniform "U_O_Wetsuit";
			_target addVest "V_RebreatherB";			
		};
		case "O_HELI_PILOT":
		{
			_target addUniform "U_O_PilotCoveralls";
			_target addVest "V_TacVest_oli";
			_target addHeadgear	"H_PilotHelmetHeli_O";			
		};
		case "O_MARKSMAN":
		{
			_target addUniform "U_O_CombatUniform_ocamo";
			_target addVest "V_TacVest_brn";
			_target addHeadgear	"H_HelmetO_ocamo";
		};
		case "O_RIFLEMAN":
		{
			_target addUniform "U_O_CombatUniform_ocamo";
			_target addVest "V_HarnessO_brn";
			_target addHeadgear	"H_HelmetO_ocamo";
		};
		case "O_AUTO_RIFLEMAN":
		{
			_target addUniform "U_O_CombatUniform_ocamo";
			_target addVest "V_HarnessO_brn";
			_target addHeadgear	"H_HelmetO_ocamo";	
		};
		case "O_LEADER":
		{
			_target addUniform "U_O_CombatUniform_ocamo";
			_target addVest "V_HarnessOGL_brn";
			_target addHeadgear	"H_HelmetO_ocamo";			
		};
		case "O_MEDIC":
		{
			_target addUniform "U_O_CombatUniform_ocamo";
			_target addVest "V_HarnessOGL_brn";
			_target addHeadgear	"H_HelmetO_ocamo";
		};
		case "O_SPECIALIST_EXPLOSIVE":
		{
			_target addUniform "U_O_CombatUniform_ocamo";
			_target addVest "V_HarnessOGL_brn";
			_target addHeadgear	"H_HelmetO_ocamo";
		};		
		case "O_SPECIALIST_REPAIR":
		{
			_target addUniform "U_O_CombatUniform_ocamo";
			_target addVest "V_HarnessOGL_brn";
			_target addHeadgear	"H_HelmetO_ocamo";
		};
		case "CIV":
		{
			_target addUniform "U_C_Poloshirt_stripped";
		};
		case "CIV1":
		{
			_target addUniform "U_C_Poloshirt_blue";
		};
		case "CIV2":
		{
			_target addUniform "U_C_Poloshirt_burgundy";
		};
		case "CIV3":
		{
			_target addUniform "U_C_Poloshirt_stripped";
		};
		case "CIV4":
		{
			_target addUniform "U_C_Poloshirt_tricolour";
		};
		case "CIV5":
		{
			_target addUniform "U_C_Poloshirt_salmon";
		};
		case "CIV6":
		{
			_target addUniform "U_C_Poloshirt_redwhite";
		};
		case "COM1":
		{
			_target addUniform "U_C_Commoner1_1";
		};
		case "COM2":
		{
			_target addUniform "U_C_Commoner1_2";
		};
		case "COM3":
		{
			_target addUniform "U_C_Commoner1_3";
		};
		case "GANGSTER1":
		{
			_target addUniform "U_C_Poloshirt_salmon";
			_target addVest "V_BandollierB_cbr";
			_target addHeadgear	"H_Cap_red";
		};
		case "GANGSTER2":
		{
			_target addUniform "U_C_Poloshirt_tricolour";
			_target addVest "V_TacVest_oli";
			_target addHeadgear	"H_MilCap_mcamo";
		};
		case "GANGSTER3":
		{
			_target addUniform "U_C_Poloshirt_stripped";
			_target addVest	"V_BandollierB_khk";
		};
		case "GANGSTER4":
		{
			_target addUniform "U_C_Poloshirt_stripped";
			_target addVest	"V_BandollierB_khk";
		};
		case "B_SPEC_OPS":
		{
			_target addUniform "U_B_CombatUniform_mcam_tshirt";
			_target addVest "V_Rangemaster_belt";
			_target addHeadgear	"H_Cap_brn_SERO";
		};
		case "B_SPEC_OPS2":
		{
			_target addUniform "U_B_CombatUniform_mcam_vest";
			_target addVest "V_BandollierB_cbr";
			_target addHeadgear	"H_MilCap_mcamo";
		};
		default
		{
		
		};
	};
};

/*
	Set Pack Loadout
*/
arjay_setPackLoadout = 
{
	private ["_target", "_preset", "_items"];
	_target = _this select 0;
	_preset = _this select 1;
	
	switch(_preset) do
	{
		case "B_DIVER":
		{
			
		};
		case "B_HELI_PILOT":
		{
			
		};
		case "B_MARKSMAN":
		{
			
		};
		case "B_RIFLEMAN":
		{
			
		};
		case "B_AUTO_RIFLEMAN":
		{
			
		};
		case "B_LEADER":
		{
			
		};
		case "B_MEDIC":
		{
			_target addBackpack "B_AssaultPack_rgr_Medic";
		};
		case "B_SPECIALIST_EXPLOSIVE":
		{
			_target addBackpack "B_Bergen_sgg_Exp";
		};
		case "B_SPECIALIST_REPAIR":
		{
			_target addBackpack "B_AssaultPack_rgr_Repair";
		};
		case "O_DIVER":
		{
			
		};
		case "O_HELI_PILOT":
		{
			
		};
		case "O_MARKSMAN":
		{
			
		};
		case "O_RIFLEMAN":
		{
			
		};
		case "O_AUTO_RIFLEMAN":
		{
			
		};
		case "O_LEADER":
		{
			
		};
		case "O_MEDIC":
		{
			_target addBackpack "B_FieldPack_ocamo_Medic";
		};
		case "O_SPECIALIST_EXPLOSIVE":
		{
			_target addBackpack "B_Carryall_ocamo_Exp";
		};
		case "O_SPECIALIST_REPAIR":
		{
			_target addBackpack "B_FieldPack_cbr_Repair";
		};
		default
		{
		
		};
	};
};

/*
	Set Item Loadout
*/
arjay_setItemLoadout = 
{
	private ["_target", "_preset", "_items"];
	_target = _this select 0;
	_preset = _this select 1;
	
	switch(_preset) do
	{
		case "B_DIVER":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "B_HELI_PILOT":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "B_MARKSMAN":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "B_RIFLEMAN":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "B_AUTO_RIFLEMAN":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "B_LEADER":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "B_MEDIC":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "B_SPECIALIST_EXPLOSIVE":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "B_SPECIALIST_REPAIR":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_DIVER":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_HELI_PILOT":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_MARKSMAN":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_RIFLEMAN":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_AUTO_RIFLEMAN":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_LEADER":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_MEDIC":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_SPECIALIST_EXPLOSIVE":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "O_SPECIALIST_REPAIR":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		case "GANGSTER1":
		{
			[_target,["ItemWatch","ItemRadio"]] call arjay_addItems;
			[_target,["ItemWatch","ItemRadio"]] call arjay_assignItems;
		};
		case "GANGSTER2":
		{
			[_target,["ItemWatch","ItemRadio"]] call arjay_addItems;
			[_target,["ItemWatch","ItemRadio"]] call arjay_assignItems;
		};
		case "GANGSTER3":
		{
			[_target,["ItemWatch","ItemRadio"]] call arjay_addItems;
			[_target,["ItemWatch","ItemRadio"]] call arjay_assignItems;
		};
		case "GANGSTER4":
		{
			[_target,["ItemWatch","ItemRadio"]] call arjay_addItems;
			[_target,["ItemWatch","ItemRadio"]] call arjay_assignItems;
		};
		case "B_SPEC_OPS":
		{
			[_target,arjay_genericItems] call arjay_addItems;
			[_target,arjay_genericItems] call arjay_assignItems;
		};
		default
		{
		
		};
	};
};

/*
	Add Weapons
*/
arjay_addWeapons = 
{
	private ["_target", "_items"];
	_target = _this select 0;
	_items = _this select 1;
	{_target addWeapon _x} forEach _items;
};

/*
	Add Magazines
*/
arjay_addMagazines = 
{
	private ["_target", "_items", "_i"];
	_target = _this select 0;
	_items = _this select 1;
	
	{
		for "_i" from 0 to arjay_magazineLimit-1 do
		{
			_target addMagazine _x;
		};
	} forEach _items;
};

/*
	Add Primary Item
*/
arjay_addPrimaryItems = 
{
	private ["_target", "_items"];
	_target = _this select 0;
	_items = _this select 1;
	{_target addPrimaryWeaponItem _x} forEach _items;
};

/*
	Add Handgun Item
*/
arjay_addHandgunItems = 
{
	private ["_target", "_items"];
	_target = _this select 0;
	_items = _this select 1;
	{_target addHandgunItem _x} forEach _items;
};

/*
	Add Item
*/
arjay_addItems = 
{
	private ["_target", "_items"];
	_target = _this select 0;
	_items = _this select 1;
	{_target addItem _x} forEach _items;
};

/*
	Assign Item
*/
arjay_assignItems = 
{
	private ["_target", "_items"];
	_target = _this select 0;
	_items = _this select 1;
	{_target assignItem _x} forEach _items;
};

/*
	Set Loadout
*/
arjay_stripLoadout = 
{
	private ["_target"];
	_target = _this select 0;
	
	removeUniform _target;
	removeAllWeapons _target;
	removeAllItems _target;
	removeAllAssignedItems _target;
	removeAllContainers _target;
	removeGoggles _target;
	removeHeadgear _target;
};
/*
	Is a unit armed
*/
arjay_isArmed = 
{
	private ["_target", "_found"];
	_target = _this select 0;
	_found = false;
	if !(primaryWeapon _target == "" &&  secondaryWeapon _target == "" && handgunWeapon _target == "") then {
		_found = true;
	};
	_found
};

/*
	Fill Ammo Box
*/
arjay_fillAmmoBox = 
{
	private["_box", "_cfgweapons", "_weapons", "_magazines", "_cur_wep", "_classname", "_wep_type", "_scope", "_picture", "_items", "_backpacks", "_glasses", "_i"];
	_box = _this select 0;

	clearWeaponCargo _box;
	clearMagazineCargo _box;
	clearItemCargo _box;
	clearBackpackCargo _box;

	_cfgweapons = configFile >> "CfgWeapons";
	_weapons = [];
	
	for "_i" from 0 to (count _cfgWeapons)-1 do
	{
		_cur_wep = _cfgweapons select _i;
		
		if(isClass _cur_wep) then
		{
			_classname = configName _cur_wep;
			_wep_type = getNumber(_cur_wep >> "type");
			_scope = getNumber(_cur_wep >> "scope");
			_picture = getText(_cur_wep >> "picture");
			//diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
			if(_scope >= 2 && _wep_type in [1,2,4,4096] && _picture != "" && !(_classname in _weapons) && _classname != "NVGoggles") then
			{
				_weapons set[count _weapons, _classname];
			};
		};
	};
	
	_cfgweapons = configFile >> "CfgMagazines";
	_magazines = [];
	
	for "_i" from 0 to (count _cfgWeapons)-1 do
	{
		_cur_wep = _cfgweapons select _i;
		
		if(isClass _cur_wep) then
		{
			_classname = configName _cur_wep;
			//_wep_type = getNumber(_cur_wep >> "type");
			_scope = getNumber(_cur_wep >> "scope");
			_picture = getText(_cur_wep >> "picture");
			if(_scope >= 2 && _picture != "" && !(_classname in _magazines)) then
			{
				_magazines set[count _magazines, _classname];
			};
		};
	};
	
	{ _box addWeaponCargo [_x,50]; } foreach _weapons;
	{ _box addMagazineCargo [_x,50]; }foreach _magazines;

	_cfgweapons = configFile >> "CfgWeapons";
	_items = [];
	
	for "_i" from 0 to (count _cfgWeapons)-1 do
	{
		_cur_wep = _cfgweapons select _i;
		
		if(isClass _cur_wep) then
		{
			_classname = configName _cur_wep;
			_wep_type = getNumber(_cur_wep >> "type");
			_scope = getNumber(_cur_wep >> "scope");
			_picture = getText(_cur_wep >> "picture");
			//diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
			if(_scope >= 2 && _wep_type in [131072,4096] && _picture != "" && !(_classname in _items) && _classname != "Binocular") then
			{
				_items set[count _items, _classname];
			};
		};
	};
	
	{ _box addItemCargo [_x,50]; } foreach _items;
	
	_cfgweapons = configFile >> "CfgVehicles";
	_backpacks = [];
	
	for "_i" from 0 to (count _cfgWeapons)-1 do
	{
		_cur_wep = _cfgweapons select _i;
		
		if(isClass _cur_wep) then
		{
			_classname = configName _cur_wep;
			_wep_type = getText(_cur_wep >> "vehicleClass");
			_scope = getNumber(_cur_wep >> "scope");
			_picture = getText(_cur_wep >> "picture");
			//diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
			if(_scope >= 2 && _wep_type == "Backpacks" && _picture != "" && !(_classname in _backpacks)) then
			{				
				_backpacks set[count _backpacks, _classname];
			};
		};
	};
	
	{ _box addBackpackCargo [_x,5]; } foreach _backpacks;
	
	/*
	_cfgweapons = configFile >> "CfgGlasses";
	_glasses = [];
	
	for "_i" from 0 to (count _cfgWeapons)-1 do
	{
		_cur_wep = _cfgweapons select _i;
		
		if(isClass _cur_wep) then
		{
			_classname = configName _cur_wep;
			_wep_type = getText(_cur_wep >> "vehicleClass");
			_scope = getNumber(_cur_wep >> "scope");
			_picture = getText(_cur_wep >> "picture");
			if(_scope >= 2 && _picture != "" && !(_classname in _glasses)) then
			{
				//diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_wep_type,_scope,_picture,_cur_wep];
				_glasses set[count _glasses, _classname];
			};
		};
	};
	
	{ _box addGoggleCargo [_x,5]; } foreach _glasses;
	*/
};