--- When not connected to Home Wifi, mute the computer to avoid awkward moment
wifiWatcher = nil
homeSSID = "Sibyl System"
lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
  newSSID = hs.wifi.currentNetwork()

  if newSSID == homeSSID and lastSSID ~= homeSSID then
    -- We just joined our home WiFi network
    hs.audiodevice.defaultOutputDevice():setVolume(25)
  elseif newSSID ~= homeSSID and lastSSID == homeSSID then
    -- We just departed our home WiFi network
    hs.audiodevice.defaultOutputDevice():setVolume(0)
  end

  lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

--- Draws on the screen
mouseCircle = nil
mouseCircleTimer = nil

function mouseHighlight()
  -- Delete an existing highlight if it exists
  if mouseCircle then
    mouseCircle:delete()
    if mouseCircleTimer then
      mouseCircleTimer:stop()
    end
  end
  -- Get the current co-ordinates of the mouse pointer
  mousepoint = hs.mouse.getAbsolutePosition()
  -- Prepare a big red circle around the mouse pointer
  mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x - 40, mousepoint.y - 40, 80, 80))
  mouseCircle:setStrokeColor({ ["red"] = 1, ["blue"] = 0, ["green"] = 0, ["alpha"] = 1 })
  mouseCircle:setFill(false)
  mouseCircle:setStrokeWidth(5)
  mouseCircle:show()

  -- Set a timer to delete the circle after 3 seconds
  mouseCircleTimer = hs.timer.doAfter(3, function()
    mouseCircle:delete()
  end)
end

function pingResult(object, message, seqnum, error)
  if message == "didFinish" then
    avg = tonumber(string.match(object:summary(), "/(%d+.%d+)/"))
    if avg == 0.0 then
      hs.alert.show("No network")
    elseif avg < 200.0 then
      hs.alert.show("Network good (" .. avg .. "ms)")
    elseif avg < 500.0 then
      hs.alert.show("Network poor(" .. avg .. "ms)")
    else
      hs.alert.show("Network bad(" .. avg .. "ms)")
    end
  end
end
