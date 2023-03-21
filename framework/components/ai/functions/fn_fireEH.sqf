#include "script_component.hpp"
/*
 * Author: Eric
 * Handles AI reaction to being lit on fire
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_ai_fnc_fireEH
 *
 * Public: Yes
 */

["ace_fire_addFireSource", {
	params ["_unit"];

	/* Make unit enter panic action */
	if (_unit isKindOf "Man" && !isPlayer _unit) then {
		_unit setBehaviour "CARELESS";
		_unit disableAI "FSM";
		_unit setUnitPosWeak "UP";
		_unit playAction "Panic";

		private _runTarget = _unit getPos [50 * sqrt random 1, random 360];
		doGetOut _unit;
		_unit doMove _runTarget;
	};
}] call CBA_fnc_addEventHandler;