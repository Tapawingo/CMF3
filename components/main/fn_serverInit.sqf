#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes Server for CMF (executed preInit).
 *
 * Public: No
 */
SCRIPT(serverInit);

if (!isServer) exitWith {};

LOG_1("Initializing CMF v%1...", VERSION_STR);
missionNamespace setVariable [QGVAR(server_initialized), false, true];

/* Print a warning if mission is run in singleplayer */
if (is3DENPreview && !is3DENMultiplayer) then {
    "CBA_diagnostic_Error" cutRsc ["CBA_diagnostic_Error", "PLAIN"];
    private _control = uiNamespace getVariable "CBA_diagnostic_Error";

    _control ctrlSetStructuredText composeText [
        lineBreak, parseText "<t align='center' size='1.65'>CMF: Singleplayer<\t>", lineBreak, lineBreak,
        "Certain parts of CMF might not work in a singleplayer enviroment. Any testing should be done in a multiplayer enviroment!"
    ];
};

/* Store CMF Version Number in variable */
missionNamespace setVariable [QGVAR(version), VERSION_STR];

/* Disable removing grass */
tawvd_disablenone = true;

/* Disable Shacktac UI groupBar */
STHud_NoSquadBarMode = true;

/* Disable CTAB on ground vehicles */
cTab_vehicleClass_has_FBCB2 = [];

/* Disable Vietnamese voices from Unsung */
RUG_DSAI_TerminalDistance = -1;

/* band aid - remove this once they fix PlayerConnected mission event handler */
// https://forums.bistudio.com/topic/143930-general-discussion-dev-branch/page-942#entry3003074
["cmf_onMissionStart_opcfix", "onPlayerConnected", {}] call BIS_fnc_addStackedEventHandler;
["cmf_onMissionStart_opcfix", "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

/* Register player */
addMissionEventHandler ["PlayerConnected", {
    private _owner = _this select 4;

    /* Raise event */
    [QGVAR(server_onPlayerConnected), _this] call CBA_fnc_globalEvent;

    [_this, FUNC(playerInit)] remoteExec ["call", _owner];
}];

INFO_1("CMF v%1 Initialized!", VERSION_STR);
missionNamespace setVariable [QGVAR(server_initialized), true, true];

/* Raise event */
[QGVAR(server_initialized), _this] call CBA_fnc_globalEvent;
