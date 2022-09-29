#include "script_component.hpp"
/*
 * Author: Eric
 * Replaces AI's ammunition with tracer rounds.
 *
 * Arguments:
 * 0: Side or Unit <SIDE/OBJECT>
 * 1: flashlight <BOOLEAN>
 * 2: Random Magazine <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [east, true, false] call cmf_gameplay_fnc_tracers
 *
 * Public: Yes
 */
SCRIPT(tracers);

if (!isServer) exitWith {};

private _fnc_applyTracers = {
	params ["_unit", ["_flash", true], ["_randomModel", false]];

	if ( !(_unit getVariable [QGVAR(tracers_initialized), false]) ) then {
		private _primaryWeaon = primaryWeapon _unit;
		private _supportedMags = [_primaryWeaon] call CBA_fnc_compatibleMagazines;

		private _tracerMags = [];
		{
			if ((getNumber (configfile >> "CfgMagazines" >> _x >> "tracersEvery")) > 0) then {
				_tracerMags pushBack _x;
			};
		} forEach _supportedMags;

		if (count _tracerMags > 0) then {
			private _newMagazine = [];
			if (_randomModel) then {
				_newMagazine pushBack (_tracerMags select (random (count _tracerMags)));
			} else {
				{
					private _curMag = getText (configfile >> "CfgMagazines" >> _x >> "model");
					private _curprimaryMag = getText (configfile >> "CfgMagazines" >> ((primaryWeaponMagazine _unit) select 0) >> "model");
					if (isNil "_curprimaryMag") then {
					    _curprimaryMag = "";
					};

					if (_curMag isEqualTo _curprimaryMag) then {
						_newMagazine pushBack _x;
					};
				} forEach _tracerMags;

				if ((count _newMagazine) == 0) then
				{
					_newMagazine pushBack (_tracerMags select 0);
				};
			};
			_newMagazine = _newMagazine select 0;

			private _magReplace = [];
			private _magCount = 1;
			{
				if (_x in _supportedMags) then {
					_magReplace = _magReplace + [_x];
					_magCount = _magCount + 1;
				};
			} forEach magazines _unit;

			if (!isNil "_newMagazine") then {
				[_unit, _primaryWeaon] call CBA_fnc_removeWeapon;
				{
					[_unit, _x] call CBA_fnc_removeMagazine;
				} forEach _magReplace;

				_unit addMagazines [_newMagazine, _magCount];
				[_unit, _primaryWeaon] call CBA_fnc_addWeapon;
			};

			LOG_1("Added tracers for %1", name _unit);
			_unit setVariable [QGVAR(tracers_initialized), true, true];
		};

		if (_flash) then {
			private _flashLights = [];
			private _compatMods = [_primaryWeaon] call CBA_fnc_compatibleItems;
			{
				if (isClass(configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "FlashLight")) then {
					if (getNumber(configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "FlashLight" >> "intensity") != 0) then {
						_flashLights pushBack _x;
					};
				};
			} forEach _compatMods;
			if (count _flashLights > 0) then {
				_unit addPrimaryWeaponItem (_flashLights select (random (count _flashLights)));
				_unit enableGunLights "ForceOn";
			};
		};
	};
};

params [["_unit", nil], ["_flash", true], ["_randomModel", false]];

LOG_1("tracers called with params %1", str _this);

/* Assumed autoinit */
if (isNil "_unit") then {
	[_fnc_applyTracers] spawn {
		params ["_fnc_applyTracers"];

		/* Check if it's enabled */
		private _enabled = ( CONFIG_PARAM_4(SETTINGS,gameplay,tracers,enable) ) isEqualTo 1;
		if !(_enabled) exitWith {};

		private _sides = CONFIG_PARAM_4(SETTINGS,gameplay,tracers,side);

		while { !(missionNamespace getVariable [QGVAR(tracers_disable), false]) } do {
			{

				{
					if (!isPlayer _x) then {
						[_x, false, false] spawn _fnc_applyTracers;
						sleep 0.03;
					};
				} forEach units call compile _x;
				sleep 0.03;
			} forEach _sides;
			sleep 1;
		};
	};
};

/* For unit */
if (IS_OBJECT(_unit)) exitWith {
	if (!isPlayer _unit) then {
		[_unit, _flash, _randomModel] call _fnc_applyTracers;
	};
};

/* For side */
if (IS_SIDE(_unit)) exitWith {
	[_unit, _flash, _randomModel, _fnc_applyTracers] spawn {
		params ["_unit", "_flash", "_randomModel", "_fnc_applyTracers"];

		while { !(missionNamespace getVariable [QGVAR(tracers_disable), false]) } do {
			{
				if (!isPlayer _x) then {
					[_x, _flash, _randomModel] spawn _fnc_applyTracers;
					sleep 0.03;
				};
			} forEach units _unit;
			sleep 1;
		};
	};
};
