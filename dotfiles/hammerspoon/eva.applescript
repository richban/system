activate application "SystemUIServer"
tell application "System Events"
    tell process "SystemUIServer"
        set btMenu to (menu bar item 1 of menu bar 1 whose description contains "volume")
        tell btMenu
            click
            try
                tell (menu item "Eva" of menu 1)
                    click
                    return "Connecting... to Eva"
                end tell
            end try
        end tell
    end tell
    key code 53
    return "Device not found or Bluetooth turned off"
end tell
