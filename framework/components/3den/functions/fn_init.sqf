disableSerialization;
#include "script_component.hpp"
/*
 * Author: Eric
 * 3DEN function init, adds all 3den tools for cmf
 *
 * Arguments:
 * 0: Argument Name <TYPE>
 *
 * Return Value:
 * Return Name <TYPE>
 *
 * Example:
 * [] execVM "functions\3den\fn_init.sqf"
 *
 * Public: No
 */
SCRIPT(init);

/* Check if menu already exists and if it does delete it */
private _ctrlMenuStrip = findDisplay 313 displayCtrl 120;
for "_i" from 0 to (_ctrlMenuStrip menuSize []) -1 step 1 do {
    if (_ctrlMenuStrip menuText [_i] isEqualTo "CMF") then {
        _ctrlMenuStrip menuDelete [_i];
    };
};

/* Set default  */
"Multiplayer" set3DENMissionAttribute ["GameType", "coop"];

/* Create CMF menu */
private _indexMain = [[], "CMF"] call FUNC(addMenuItem);
[_indexMain] call FUNC(main_setConfig);
private _indexUnits = [[_indexMain], LSTRING(unit_spawner_displayName), "a3\ui_f\data\igui\rscingameui\rscunitinfo\si_stand_ca.paa"] call FUNC(addMenuItem);
private _indexTools = [[_indexMain], LSTRING(tools_displayName), "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_functions_ca.paa"] call FUNC(addMenuItem);

private _indexLobby = [[_indexMain], LSTRING(lobby_manager_displayName), "a3\ui_f\data\gui\rsc\rscdisplaymain\menu_multiplayer_ca.paa", {
    call (uiNamespace getVariable 'CBA_fnc_openLobbyManager');
}] call FUNC(addMenuItem);

private _indexIcons = [[_indexMain], LSTRING(iconviewer_displayName), "a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa", {
    ["onload"] call FUNC(main_iconViewer);
}] call FUNC(addMenuItem);

private _indexBug = [[_indexMain], LSTRING(report_bug), "a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa", {
    createDialog "cmf_utility_reportBug";
}] call FUNC(addMenuItem);

missionNameSpace setVariable [QGVAR(menu_main), [_indexMain]];
missionNameSpace setVariable [QGVAR(menu_unit), [_indexMain, _indexUnits]];
missionNameSpace setVariable [QGVAR(menu_entity), [_indexMain, _indexTools]];