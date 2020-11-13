--------------------------------------------------------------------------------
-- Unsupported Spaces extension. Uses private APIs but works okay.
-- (http://github.com/asmagill/hammerspoon_asm.undocumented)
spaces = require("hs._asm.undocumented.spaces")

require('utils')
require('shortcuts')

local hyper = { "cmd", "alt", "ctrl", "shift" }

hs.hotkey.bind(hyper, "0", function()
  hs.reload()
end)

--- quick open applications
hs.hotkey.bind(hyper, "f", function()
        local shell_cmd = "open ~/Developer"
        hs.execute(shell_cmd)
end)

hs.hotkey.bind(hyper, "c", open("Google Chrome"))
hs.hotkey.bind(hyper, "t", open("iTerm"))
hs.hotkey.bind(hyper, "v", open("Visual Studio Code"))

--- Conect to Adam
hs.hotkey.bind(hyper, "a", function()
    local _, output = hs.osascript.applescriptFromFile("adam.applescript")    
    hs.notify.new({title="Hammerspoon", informativeText=output}):send()
end)

--- Connect to Eva
hs.hotkey.bind(hyper, "e", function()
    local _, output = hs.osascript.applescriptFromFile("eva.applescript")    
    hs.notify.new({title="Hammerspoon", informativeText=output}):send()
end)

hs.hotkey.bind(hyper, "p", function()
    hs.network.ping.ping("8.8.8.8", 1, 0.01, 1.0, "any", pingResult)
end)

--- draw mouse 
hs.hotkey.bind(hyper, "M", mouseHighlight)

hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

--- Toogle Microphone 

function displayMicMuteStatus()
    local currentAudioInput = hs.audiodevice.current(true)
    local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
    muted = currentAudioInputObject:inputMuted()
    if muted then
        hs.alert.show("Microphone Muted")
    else
        hs.alert.show("Microphone Unmuted")
    end
end

for i,dev in ipairs(hs.audiodevice.allInputDevices()) do
   dev:watcherCallback(displayMicMuteStatus):watcherStart()
end

function toggleMicMuteStatus()
    local currentAudioInput = hs.audiodevice.current(true)
    local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
    currentAudioInputObject:setInputMuted(not muted)
    displayMicMuteStatus()
end

displayMicMuteStatus()

hs.hotkey.bind(hyper, "m", toggleMicMuteStatus)

