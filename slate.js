S.log("Loading the slate config...");
slate.configAll({
    "defaultToCurrentScreen": true,
    "nudgePercentOf": "screenSize",
    "resizePercentOf": "screenSize",
    "secondsBetweenRepeat": 0.1,
    "checkDefaultsOnLoad": true,
    "focusCheckWidthMax": 3000,
    "windowHintsShowIcons": true,
    "windowHintsIgnoreHiddenWindows": false,
    "windowHintsSpread": true,
    "windowHintsWidth": 120,
    "windowHintsHeight": 120,
    "windowHintsDuration": 5,
});
var hintLeftHand = slate.operation("hint", {
  "characters" : 'AOEUIYQJKX'
});
var hintFull = slate.operation("hint", {
  "characters" : "AOEUIDHTNSYXFBPKGMCW"
});

var monLaptop = "1280x800";
var monLeftDell = "2560x1024";
var monRightDell = "2560x1024";
var monHome = "2560x1440";
var absFull = slate.operation("move", {
  "x": "screenOriginX",
  "y": "screenOriginY",
  "width": "screenSizeX",
  "height": "screenSizeY"
});
/* uneven parts */
var absRightMost = absFull.dup({
  "x" : "screenOriginX+screenSizeX*0.4",
  "width": "screenSizeX*0.6"
});
var absRightLess = absFull.dup({
  "x": "screenOriginX+screenSizeX*0.6",
  "width": "screenSizeX*0.4"
});
var absLeftMost = absFull.dup({
  "width": "screenSizeX*0.6"
});
var absLeftLess = absFull.dup({
  "width": "screenSizeX*0.4"
});
/* halfs */
var absLeftHalf = absFull.dup({
  "width": "screenSizeX/2"
});
var absRightHalf = absFull.dup({
  "x": "screenOriginX+screenSizeX/2",
  "width": "screenSizeX/2"
});
var absTopHalf = absFull.dup({
  "height": "screenSizeY*0.5"
});
var absBottomHalf = absTopHalf.dup({
  "y": "screenOriginY+screenSizeY*0.5"
});
/* quarters */
var absTopLeft = slate.operation("corner", {
  "direction" : "top-left",
  "width": "screenSizeX/2",
  "height": "screenSizeY/2"
});
var absTopRight = absTopLeft.dup({ "direction": "top-right" });
var absBottomLeft = absTopLeft.dup({"direction": "bottom-left"});
var absBottomRight = absTopLeft.dup({"direction": "bottom-right"});

// var throwToNextScreen = slate.operation("throw", "next");

/* focus operations */
var focusUp = slate.operation( "focus", { "direction" : "up" });
var focusDown = slate.operation("focus", { "direction" : "down" });
var focusLeft = slate.operation("focus", { "direction" : "left" });
var focusRight = slate.operation("focus", { "direction" : "right" });

function focusApp(appName) {
  return slate.operation("focus", { "app": appName});
}

/* resize operations */
var shrinkHorizontal = slate.operation("resize", {
  "width": "-5%",
  "height": "+0"
});
var expandHorizontal = slate.operation("resize", {
  "width": "+5%",
  "height": "+0"
});
var shrinkVertical = slate.operation("resize", {
  "width": "+0",
  "height": "-5%"
});
var expandVertical = slate.operation("resize", {
  "width": "+0",
  "height": "-5%"
});

/* grids */
var showGrid = slate.operation("grid", {
  "grids" : {
    "1280x800": {
      "width": 10,
      "height": 6
    },
    "2560x1400": {
      "width": 16,
      "height": 6
    }
  },
  "padding": 3
});



var absLeftThird = absFull.dup({ width: "screenSizeX/3"});
var absLeftTwoThirds = absFull.dup({ width: "2*screenSizeX/3"});
var absRightThird = absFull.dup({
  "x": "screenOriginX+2*screenSizeX/3",
  "width": "screenSizeX/3"
});
var absMidThird = absFull.dup({
  "x": "screenOriginX + screenSizeX/3",
  "width": "screenSizeX/3"
});
var absRightTwoThirds = absMidThird.dup({
  "width": "2*screenSizeX/3"
});

/* concrete positions */
/* macbook */
var con_lap_full = absFull.dup({ "screen": monLaptop });
var con_lap_left = absLeftHalf.dup({ "screen": monLaptop });
var con_lap_right = absRightHalf.dup({ "screen": monLaptop });
var con_lap_right_bottom = absBottomRight.dup({ "screen": monLaptop });
var con_lap_left_bottom = absBottomLeft.dup({"screen": monLaptop });

/* work dell left */
var con_leftdell_full = absFull.dup({ "screen": monLeftDell });
var con_leftdell_left = absLeftHalf.dup({ "screen": monLeftDell });
var con_leftdell_right = absRightHalf.dup({ "screen": monLeftDell });
var con_leftdell_right_bottom = absBottomRight.dup({ "screen": monLeftDell });
var con_leftdell_left_bottom = absBottomLeft.dup({"screen": monLeftDell });

/* work dell right */
var con_rightdell_full = absFull.dup({ "screen": monRightDell });
var con_rightdell_left = absLeftHalf.dup({ "screen": monRightDell });
var con_rightdell_right = absRightHalf.dup({ "screen": monRightDell });
var con_rightdell_right_bottom = absBottomRight.dup({ "screen": monRightDell });
var con_rightdell_left_bottom = absBottomLeft.dup({"screen": monRightDell });

var con_leftdell_right_chat = slate.operation("push", {
  "screen" : monRightDell,
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/9"
});

/* home monitor */
var con_home_right_chat = con_leftdell_right_chat.dup({"screen": monHome });
var con_home_left_bottom = absBottomLeft.dup({"screen" : monHome });

/* layouts */

function hideApp(appName) {
  return slate.operation("hide", { "app" : appName });
}

/*   macbook  only */
var macbookOnly = slate.layout("macbook", {
  "iTerm2": {
    "operations": con_lap_right,
    "main-first": true
  },
  "Adium": {
    "operations": hideApp("Adium")
  },
  "Google Chrome": {
    "operations": con_lap_left,
    "repeat": true,
  },
  "Dash": {
    "operations": hideApp("Dash")
  },
  "Todoist": {
    "operations": hideApp("Todoist")
  },
  "Outlook": {
    "operations": hideApp("Outlook")
  },
  "VidyoDesktop": {
    "operations" : [con_lap_right],
    "repeat": true,
    "main-last": true
  }

});

var twoMonitors = slate.layout("twoMonitors", {
  "iTerm2": {
    "operations": [con_rightdell_left, con_rightdell_right]
  },
  "Google Chrome": {
    "operations" : con_leftdell_full,
    "main-last": true,
    "repeat": true
  },
  "Outlook": {
    "operations": hideApp("Outlook")
  },
  "Adium": {
    "operations": [con_leftdell_right_chat, con_leftdell_left_bottom],
    "ignore-fail": true,
    "title-order": ["Contacts"],
    "repeat-last": true
  },
  "VidyoDesktop": {
    "operations": [con_rightdell_right],
  },
  "Spotify": {
    "operations" : [con_rightdell_full]
  }
});
var homeLayout = slate.layout("homeLayout", {
  "iTerm2" : {
    "operations": [absRightHalf],
  },
  "Google Chrome": {
    "operations": [absTopLeft, absBottomLeft],
  },
  "Adium" : {
    "operations" :  [con_home_right_chat, con_home_left_bottom],
    "ignore-fail": true,
    "title-order": ["Contacts"],
    "repeat-last": true
  },
  "Todoist" : {
    "operations" : absBottomLeft
  },
});
/* apply layouts when specific monitors are connected */
slate.default(["1280x800"], macbookOnly);
slate.default(["2560x1400", "2560x1400?"], twoMonitors);
slate.default(["2560x1440"], homeLayout);


// # Numpad location Bindings
// bind pad0 ${showHintsLeftHand}
// bind pad1:shift ${leftless}
// bind pad1 ${lbottom}
// bind pad2 push bottom bar-resize:screenSizeY/2
// bind pad3:shift ${rightless}
// bind pad3 ${rbottom}
// bind pad4 ${lefthalf}
// bind pad5 ${full}
// bind pad6 ${righthalf}
// bind pad7:shift ${leftmost}
// bind pad7 ${ltop}
// bind pad8 push top bar-resize:screenSizeY/2
// bind pad9:shift ${rightmost}
// bind pad9 ${rtop}
// #bind padEnter grid padding:5 ${monLaptop}:6,2 ${mon-samsung}:8,3
// bind pad* grid padding:5 ${monLaptop}:6,2 ${mon-samsung}:8,3
// bind pad+ throw next
// bind pad. focus behind
// bind pad- layout 2monitors
// bind pad/ layout 1monitor
// bind f13 layout 2monitors

/* bindings */
var hyper = ":ctrl;shift;alt;cmd";
bindings = {};

  bindings["1" + hyper] = absTopLeft;
  bindings["2" + hyper] = absTopRight;
  bindings["3" + hyper] = absBottomLeft;
  bindings["4" + hyper] = absBottomRight;
  // Location bindings
  bindings["l" + hyper] = absLeftHalf;
  bindings["f" + hyper] = absFull;
  bindings["r" + hyper] = absRightHalf;
  bindings["l" + hyper] = absLeftHalf;
  // bindings["n" + hyper] = throwToNextScreen;
  bindings["q" + hyper] = absTopHalf;
  bindings["z" + hyper] = absBottomHalf;
  bindings["t" + hyper] = absLeftThird;
  bindings["y" + hyper] = absRightTwoThirds;
  bindings["g" + hyper] = absLeftTwoThirds;
  bindings["h" + hyper] = absRightThird;
  bindings["j" + hyper] = absMidThird;
  // Focus bindings (general)
  bindings["left" + hyper] = focusLeft;
  bindings["right" + hyper] = focusRight;
  bindings["up" + hyper] = focusUp;
  bindings["down" + hyper] = focusDown;
  // Focus (app specific)
  bindings["b" + hyper] = focusApp("Google Chrome");
  bindings["m" + hyper] = focusApp("Adium");
  bindings["o" + hyper] = focusApp("Microsoft Outlook");
  bindings["v" + hyper] = focusApp("VidyoDesktop");
  bindings["i" + hyper] = focusApp("iTerm2");
  // Other
  bindings["n" + hyper] = showGrid;
  bindings["e" + hyper] = hintLeftHand;
  bindings["p" + hyper] = slate.operation("relaunch");
slate.bindAll(bindings);

/* vim:set ts=2 sw=2 sts=2 et */
