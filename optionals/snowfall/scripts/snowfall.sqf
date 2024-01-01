#include "script_component.hpp"
/*
 * Author: JW, Eric
 * Creates a light snowfall
 * 
 * Arguments:
 * 0: Start Density <NUMBER>
 * 1: Max Density <NUMBER>
 * 2: Object <OBJECT>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call compile PreprocessFilelineNumbers "rsc\scripts\snowfall.sqf"
 * 
 * Public: Yes
 */

if (!canSuspend) exitWith {
    [] execVM "rsc\scripts\snowfall.sqf";
};

if (!hasInterface) exitWith {};

private["_fog"];
params [["_density", 100], ["_maxDensity", 10000]];

setWind [0, -5, true];
AZC_DO_SNOW = true;
AZC_MAX_DENSITY = 10000;

GVAR(snow) = true;
GVAR(snowMaxDensity) = _maxDensity;

private _pos = position (vehicle cmf_player);
private _d  = 15;
private _nextChange = time + 30000;

FUNC(isInside) = {
    _center = _this;
    _inside = false;
    _worldPos = getPosWorld _center;
    _skyPos = getPosWorld _center vectorAdd [0, 0, 50];
    _line = lineIntersectsSurfaces [_worldPos,_skyPos,_center,objNull,true,1,"GEOM","NONE"];
    if (count _line > 0) then
    {
        _result = _line select 0;
        _house = _result select 3;
        if (_house isKindOf "House") then { _inside = true };
    };
    
    _inside
};

FUNC(snowFogEffect) = {
    _fog = "#particlesource" createVehicleLocal _pos; 
    _fog setParticleParams [
    ["\Ca\Data\ParticleEffects\Universal\universal.p3d" , 16, 12, 13, 0], "", "Billboard", 1, 10, 
    [0, 0, -6], [0, 0, 0], 1, 1.275, 1, 0, 
    [5,4], [[1, 1, 1, 0], [1, 1, 1, 0.04], [1, 1, 1, 0]], [1000], 1, 0, "", "", cmf_player
    ];
    _fog setParticleRandom [3, [55, 55, 0.2], [0, 0, -0.1], 2, 0.45, [0, 0, 0, 0.1], 0, 0];
    _fog setParticleCircle [0.001, [0, 0, -0.12]];
    _fog setDropInterval 0.001;
    _fog
};

_inside = false;
GVAR(customWeather) = true;

while { GVAR(snow) } do {
    _a = 0;
    while { _a < _density } do {
        _inside = player call FUNC(isInside);
        if (!_inside) then {
            _pos = getPosATL (vehicle cmf_player);
            if (isNil "_fog" && _density > 4000) then {
                _fog = call FUNC(snowFogEffect);
            };
            
            if (!isNil "_fog") then { _fog setpos _pos };
            0 setRain 0;
            
            _dpos = [((_pos select 0) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 1) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 2) + 2)];
            drop ["\ca\data\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,1], [1,1,1,1], [1,1,1,1]], [0,0], 0.2, 1.2, "", "", ""];    _a = _a + 1;
            _dpos = [((_pos select 0) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 1) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 2) + 4)];
            drop ["\ca\data\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,1], [1,1,1,1], [1,1,1,1]], [0,0], 0.2, 1.2, "", "", ""];    _a = _a + 1;
            _dpos = [((_pos select 0) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 1) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 2) + 6)];
            drop ["\ca\data\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,1], [1,1,1,1], [1,1,1,1]], [0,0], 0.2, 1.2, "", "", ""];    _a = _a + 1;
            _dpos = [((_pos select 0) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 1) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 2) + 8)];
            drop ["\ca\data\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,1], [1,1,1,1], [1,1,1,1]], [0,0], 0.2, 1.2, "", "", ""];    _a = _a + 1;
            _dpos = [((_pos select 0) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 1) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 2) + 10)];
            drop ["\ca\data\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,1], [1,1,1,1], [1,1,1,1]], [0,0], 0.2, 1.2, "", "", ""];    _a = _a + 1;
            _dpos = [((_pos select 0) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 1) + (_d - (random (2*_d))) + ((velocity vehicle player select 0)*1)),((_pos select 2) + 12)];
            drop ["\ca\data\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,1], [1,1,1,1], [1,1,1,1]], [0,0], 0.2, 1.2, "", "", ""];    _a = _a + 1;
        };
    };

    sleep 0.1;
/* 		if (time > _nextChange && _density < GVAR(snowMaxDensity)) then {
        _density = _density + 500;
        _nextChange = _nextChange + 30;
    }; */
};

// if snow flag is set to false code will execute here
GVAR(customWeather) = false;