local hyper = { "cmd", "alt", "ctrl", "shift" }

--- A closure function
function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

--- quick open applications
hs.hotkey.bind(hyper, "f", open("Finder"))
hs.hotkey.bind(hyper, "c", open("Google Chrome"))
hs.hotkey.bind(hyper, "t", open("iTerm"))
hs.hotkey.bind(hyper, "v", open("Visual Studio Code"))
