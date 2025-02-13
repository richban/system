require("utils")
require("shortcuts")

local hyper = { "cmd", "alt", "ctrl", "shift" }

hs.hotkey.bind(hyper, "0", function()
  hs.reload()
end)

--- quick open applications
hs.hotkey.bind(hyper, "o", function()
  local shell_cmd = "open ~/Developer"
  hs.execute(shell_cmd)
end)

hs.hotkey.bind(hyper, "c", open("Google Chrome"))
hs.hotkey.bind(hyper, "t", open("Alacritty"))
hs.hotkey.bind(hyper, "v", open("Visual Studio Code"))

hs.hotkey.bind(hyper, "p", function()
  hs.network.ping.ping("8.8.8.8", 1, 0.01, 1.0, "any", pingResult)
end)

--- draw mouse
hs.hotkey.bind(hyper, "l", mouseHighlight)

hs.notify.new({ title = "Hammerspoon", informativeText = "Config loaded" }):send()

--- Toogle Microphone

function displayMicMuteStatus()
  local currentAudioInput = hs.audiodevice.current(true)
  if not currentAudioInput then
    hs.alert.show("No audio input device found")
    return
  end

  local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
  if not currentAudioInputObject then
    hs.alert.show("Could not find audio input device")
    return
  end

  local muted = currentAudioInputObject:inputMuted()
  if muted then
    hs.alert.show("Microphone Muted")
  else
    hs.alert.show("Microphone Unmuted")
  end
end

for i, dev in ipairs(hs.audiodevice.allInputDevices()) do
  dev:watcherCallback(displayMicMuteStatus):watcherStart()
end

function toggleMicMuteStatus()
  local currentAudioInput = hs.audiodevice.current(true)
  if not currentAudioInput then
    hs.alert.show("No audio input device found")
    return
  end

  local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
  if not currentAudioInputObject then
    hs.alert.show("Could not find audio input device")
    return
  end

  local muted = currentAudioInputObject:inputMuted()
  currentAudioInputObject:setInputMuted(not muted)
  displayMicMuteStatus()
end

displayMicMuteStatus()

hs.hotkey.bind(hyper, "m", toggleMicMuteStatus)
