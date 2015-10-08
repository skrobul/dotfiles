

local mash = {
  split   = {"ctrl", "alt", "cmd"},
  corner  = {"ctrl", "alt", "shift"},
  focus   = {"ctrl", "alt"},
  utils   = {"ctrl", "alt", "cmd"},
  hyper   = {"ctrl", "alt", "cmd", "shift" }
}


local animationDuration = 0


-- Focus windows
local function focus(direction)
  local fn = "focusWindow" .. (direction:gsub("^%l", string.upper))

  return function()
    local win = hs.window:focusedWindow()
    if not win then return end

    win[fn]()
  end
end

-- Resize windows
local function adjust(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    if not win then return end

    local f = win:frame()
    local max = win:screen():frame()

    f.w = math.floor(max.w * w)
    f.h = math.floor(max.h * h)
    f.x = math.floor((max.w * x) + max.x)
    f.y = math.floor((max.h * y) + max.y)

    win:setFrame(f)
  end
end

local function adjustCenterTop(w, h)
  return function()
    local win = hs.window.focusedWindow()
    if not win then return end

    local f = win:frame()
    local max = win:screen():frame()

    f.w = math.floor(max.w * w)
    f.h = math.floor(max.h * h)
    f.x = math.floor((max.w / 2) - (f.w / 2))
    f.y = max.y
    win:setFrame(f)
  end
end

local function stoken()
    os.execute("~/bin/rsa")
    hs.alert.show("Token pasted")
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end

-- top half
hs.hotkey.bind(mash.hyper, "t", adjust(0, 0, 1, 0.5))

-- right half
hs.hotkey.bind(mash.hyper, "r", adjust(0.5, 0, 0.5, 1))

-- bottom half
hs.hotkey.bind(mash.hyper, "b", adjust(0, 0.5, 1, 0.5))

-- left half
hs.hotkey.bind(mash.hyper, "l", adjust(0, 0, 0.5, 1))

-- top left
hs.hotkey.bind(mash.hyper, "1", adjust(0, 0, 0.5, 0.5))

-- top right
hs.hotkey.bind(mash.hyper, "2", adjust(0.5, 0, 0.5, 0.5))

-- bottom left
hs.hotkey.bind(mash.hyper, "3", adjust(0, 0.5, 0.5, 0.5))

-- bottom right
hs.hotkey.bind(mash.hyper, "4", adjust(0.5, 0.5, 0.5, 0.5))

-- fullscreen
hs.hotkey.bind(mash.hyper, "f", adjustCenterTop(1, 1))

-- stoken
hs.hotkey.bind(mash.hyper, "m", stoken)

-- config reload
hs.hotkey.bind(mash.hyper, "0", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

-- window hints
hs.hotkey.bind(mash.hyper, "e", hs.hints.windowHints)

-- application specific shortcuts
local function focusApp(app)
    return function()
        hs.application.launchOrFocus(app)
    end
end

hs.hotkey.bind(mash.hyper, "i", focusApp("iTerm"))
hs.hotkey.bind(mash.hyper, "b", focusApp("Google Chrome"))
hs.hotkey.bind(mash.hyper, "v", focusApp("VidyoDesktop"))

