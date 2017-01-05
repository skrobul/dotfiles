
local mash = {
  split   = {"ctrl", "alt", "cmd"},
  corner  = {"ctrl", "alt", "shift"},
  focus   = {"ctrl", "alt"},
  utils   = {"ctrl", "alt", "cmd"},
  hyper   = {"ctrl", "alt", "cmd", "shift" }
}

hs.window.animationDuration = 0

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")



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
local function twoscreen()
    return function()
        local win = hs.window.focusedWindow()
        if not win then return end

        local s = win:screen()
        local screenpos_x, screenpos_y = s:position()
        if screenpos_x == 0 then
            hs.grid.pushWindowNextScreen()
        end
        local f = win:frame()
        local max = win:screen():frame()

        f.w = math.floor(max.w * 2)
        f.h = math.floor(max.h) - 20
        f.x = max.x
        f.y = 20
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

local frameCache = {}
local function maximize()
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:maximize()
    end
end

local function stoken()
    local x = hs.execute("bash -l /Users/marek.skrobacki/bin/rsa -v")
    hs.eventtap.keyStrokes(x)
end

-- top half
k:bind({}, "t", adjust(0, 0, 1, 0.5))

-- right half
k:bind({}, "r", adjust(0.5, 0, 0.5, 1))

-- bottom half
k:bind({}, "d", adjust(0, 0.5, 1, 0.5))

-- left half
k:bind({}, "l", adjust(0, 0, 0.5, 1))

-- top left
k:bind({}, "1", adjust(0, 0, 0.5, 0.5))

-- top right
k:bind({}, "2", adjust(0.5, 0, 0.5, 0.5))

-- bottom left
k:bind({}, "3", adjust(0, 0.5, 0.5, 0.5))

-- bottom right
k:bind({}, "4", adjust(0.5, 0.5, 0.5, 0.5))

-- fullscreen
k:bind({}, "f", maximize)


-- twoscreen
k:bind({}, "g", twoscreen())

-- stoken
k:bind({}, "m", stoken)

-- config reload
k:bind({}, "0", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

-- window hints
k:bind({}, "e", hs.hints.windowHints)

-- application specific shortcuts
apps = {
    i = 'iTerm',
    b = 'Google Chrome',
    v = 'VidyoDesktop',
    o = 'MacVim'
}

for key, app in pairs(apps) do
    k:bind({}, key, function() hs.application.launchOrFocus(app) end)
end


-- grid
hs.grid.MARGINX     = 0
hs.grid.MARGINY     = 0
hs.grid.GRIDWIDTH   = 7
hs.grid.GRIDHEIGHT  = 3

hs.hotkey.bind(mash.focus, 'H', hs.grid.pushWindowLeft)
hs.hotkey.bind(mash.focus, 'J', hs.grid.pushWindowDown)
hs.hotkey.bind(mash.focus, 'K', hs.grid.pushWindowUp)
hs.hotkey.bind(mash.focus, 'L', hs.grid.pushWindowRight)

-- resize windows
hs.hotkey.bind(mash.focus, 'Y', hs.grid.resizeWindowThinner)
hs.hotkey.bind(mash.focus, 'U', hs.grid.resizeWindowTaller)
hs.hotkey.bind(mash.focus, 'I', hs.grid.resizeWindowShorter)
hs.hotkey.bind(mash.focus, 'O', hs.grid.resizeWindowWider)

-- global operations
hs.hotkey.bind(mash.focus, ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash.focus, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)


-- multi monitor
k:bind({}, 'N', hs.grid.pushWindowNextScreen)
k:bind({}, 'P', hs.grid.pushWindowPrevScreen)

-- microphone
local function getmicvolume()
    local _, res = hs.applescript.applescript('input volume of (get volume settings)')
    return tonumber(res)
end

local function update_mic_bar(vol)
    if vol > 5 then
        micBar:setTitle('U!')
    else
        micBar:setTitle('M')
    end
end
local function setMicVol(vol)
    hs.applescript.applescript('set volume input volume  ' .. tostring(vol))
end

local function toggleMic()
    local vol = getmicvolume()
    if vol > 0 then
        hs.alert("Muted")
        setMicVol(0)
        update_mic_bar(0)
    else
        hs.alert("ON-AIR")
        setMicVol(98)
        update_mic_bar(98)
    end
end
micBar = hs.menubar.new()
update_mic_bar(getmicvolume())
k:bind({}, '\\', toggleMic)


-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
