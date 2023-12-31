#define MODULE viewdistance
#define MODULE_BEAUTIFIED View Distance

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_VIEWDISTANCE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_VIEWDISTANCE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_VIEWDISTANCE
#endif

#include "..\main\script_component.hpp"

#include "\a3\ui_f\hpp\definedikcodes.inc"
#include "\a3\ui_f\hpp\definecommongrids.inc"

#define DIALOG_CENTER ((20 * GUI_GRID_CENTER_W) / 2) - GUI_GRID_W

#define SLIDER_HEIGHT 1.3 * GUI_GRID_CENTER_H
#define SLIDER_WIDTH 20 * GUI_GRID_CENTER_W
#define SLIDER_X DIALOG_CENTER + (0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X)
#define SLIDER_GAP 0.01
#define SLIDER_Y(var1) (SLIDER_HEIGHT + SLIDER_GAP) * var1

#define LABEL_X SLIDER_X + SLIDER_WIDTH + SLIDER_GAP

#define BUTTON_GAP 0.025
#define BUTTON_W ((SLIDER_WIDTH / 3) - BUTTON_GAP)
#define BUTTON_X(var1) SLIDER_X + (BUTTON_W * var1) + (BUTTON_GAP * var1)

#define IDC_SLIDER_VIEWDISTANCE 500
#define IDC_SLIDER_OBJECTS 501
#define IDC_SLIDER_PIP 502
#define IDC_SLIDER_SHADOW 503
#define IDC_SLIDER_TERRAIN 504

#define IDC_LABEL_VIEWDISTANCE 400
#define IDC_LABEL_OBJECTS 401
#define IDC_LABEL_PIP 402
#define IDC_LABEL_SHADOW 403
#define IDC_LABEL_TERRAIN 404

#define IDC_BUTTON_INFANTRY 600
#define IDC_BUTTON_VEHICLE 601
#define IDC_BUTTON_AIR 602