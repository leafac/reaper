-- Preferences for LeaFac's-OBS <-> Reaper integration
-- Version 1.0 written by Meo-Ada Mespotine 17th of February 2021 - licensed under MIT-license


-- TODO:
--  Retina-Support missing
--  Check settings-button is not functional yet(please include the code into CheckSettings() )
--  Check tooltips if they are correct and have no typos.


-- [[ Some Custom Settings ]]

-- Default Window position and size:
--    X and Y will be used the first time the preferences are opened
--    when closing the prefs, the prefs remember the position of the window for next time
WindowX     = 30 -- x-position
WindowY     = 30 -- y-position
WindowWidth = 400 -- width of the window
WindowHeight= 339 -- height of the window

ToolTipWaitTime=30 -- the waittime-until tooltips are shown when hovering above them; 30~1 second

YDefault=0          -- The Y-position of the first GUI-Element. So if you want to move all of them lower, raise this value
XOffset=43          -- X-offset of the second element in the gui(usually text inputfields), so you can move the inputfields to the right together
                    -- if an explanation-text becomes too long to be drawn


-- [[ The following functions can be customized by you ]]

function main()
  -- This function manages all the drawing and positioning of the gui-elements.
  -- If you need more gui-elements, simply add them into here.
  -- All Gui-element-functions like DrawText(), InputText(), ManageCheckBox(), ManageButton() have
  -- a description of their parameters included. Just go to the function-definitions and read their comments.
  
  -- Now, let's add the individual UI-elements
  -- Header
  Y=Y+10 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText(10, Y, "LeaFac OBS - Preferences", 85, "", 20) 
  
  -- Address - text and inputbox
  --  the length is linked to gfx.w, so it always uses the whole window for display
  Y=Y+30 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText (10,  Y, "Address:", 0, "The address to OBS-websocket.\nMust be the same, as set in OBS -> Tools -> Websockets-serversettings.\n\nDefault is: localhost:4444")
  InputText(100+XOffset, Y, gfx.w-110-XOffset, "LeaFac_OBS", "Address", "localhost:4444", "Enter Address to OBS", "Address")
    
  -- Password - text and inputbox
  --  the length is linked to gfx.w, so it always uses the whole window for display
  Y=Y+21 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText (10,  Y, "Password:", 0, "The password for your OBS-websocket connection.\nMust be the same, as set in OBS -> Tools -> Websockets-serversettings.\n\nDefault is no password.")
  InputText(100+XOffset, Y, gfx.w-110-XOffset, "LeaFac_OBS", "Password", "", "Enter Password", "Password")
  
  -- Extension - text and inputbox
  Y=Y+21 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText (10,  Y, "Extension:", 0, "The extension of the recorded video, as set in OBS.\n\nDefault is: mkv.")
  InputText(100+XOffset, Y, 50, "LeaFac_OBS", "Extension", "mkv", "Enter extension", "Extension")
  
  -- Subfolder - text and inputbox
  --  the length is linked to gfx.w, so it always uses the whole window for display
  Y=Y+21 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText (10,  Y, "Subfolder:", 0, "The subfolder within your project, in which the video-file shall be.\n\nDefault is none.")
  InputText(100+XOffset, Y, gfx.w-110-XOffset, "LeaFac_OBS", "Subfolder", "", "Enter subfolder", "Subfolder")
  
  -- Latency - text and inputbox
  Y=Y+30 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText (10,  Y, "Latency:", 0, "If you notice an offset between audio and video after the video got imported into Reaper, you can set the offset to compensate the latency here in ms.\n\nDefault is 0.")
  InputText(100+XOffset, Y, 50, "LeaFac_OBS", "Latency", "0", "Enter latency", "Latency", true)
  
  -- Execute Timeout - text and inputbox
  Y=Y+21 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText (10,  Y, "Execute Timeout:", 0, "The time to wait for a response of OBS, before an error-message will be shown.\n\nDefault is 5000 ms.")
  InputText(100+XOffset, Y, 50, "LeaFac_OBS", "EXECUTE_TIMEOUT", "5000", "Enter extension", "Extension", true)
    
  -- OBS Stop Recording Timeout - text and inputbox
  Y=Y+21 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText (10,  Y, "Stop Rec Timeout:", 0, "\n\nDefault is 10.")
  InputText(100+XOffset, Y, 50, "LeaFac_OBS", "OBS_STOP_RECORDING_TIMEOUT", "10", "Enter recording timeout", "Recording Timeout", true)
    
  -- TrackName - text and inputbox
  --  the length is linked to gfx.w, so it always uses the whole window for display
  Y=Y+35 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  DrawText (10,  Y, "TrackName:", 0, "The name of a track, into which the video is imported to.\n\nDefault is OBS.")
  InputText(100+XOffset, Y, gfx.w-110-XOffset, "LeaFac_OBS", "TRACK_NAME", "OBS", "Enter Trackname", "Trackname")
  
  -- alway create new track-text and checkbox
  Y=Y+24 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  ManageCheckBox(100+XOffset-1, Y,   "LeaFac_OBS",              "ALWAYS_CREATE_NEW_TRACK", false)
  DrawText      (125+XOffset,   Y+2, "Always create new track", 0, "When checked, this will always create a new track when starting recording, so multiple files are always placed into new tracks. When unchecked, all files will be added to the same track.\n\nDefault is unchecked.")
    
  
  -- Check Settings and Done-buttons
  --  these are linked to gfx.w(right side of the window) so they are always aligned to the right-side of the window
  Y=Y+43 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  ManageButton(gfx.w-260, Y, "Default Settings", ResetSettings)
  ManageButton(gfx.w-132, Y, "Check Settings",   CheckSettings)
  Y=Y+29 -- This holds the position of the next ui-element. I simply add a value, so it stays relative to the one above it.
  ManageButton(gfx.w-68, Y, "Done", QuitMe)
  
  
  
  -- make some mouse-management, run refresh the window again, until the window is closed, otherwise end script
  -- leave it untouched
  if Key~=-1 then OldCap2=gfx.mouse_cap&1 reaper.defer(RefreshWindow) end
end



-- [[ Custom Button functions ]]
--
-- here are some custom-functions used by the buttons.
-- If you want to add additional buttons, add their accompanying functions in this section

function CheckSettings()
  -- Please put it in here the checking-mechanism for checking validity of connection.
  -- use reaper.MB to output an error-message
  reaper.MB("You need to add the check-settings-code into the function \"CheckSettings\" for this button to work, as you probably know better, how this works.","Not yet implemented.",0)
end

function ResetSettings()
  -- This function resets all the settings to their defaults.
  -- The settings are deleted, so the start/stop-recording-scripts need to check, if the setting exists, via GetExtState.
  -- If GetExtState returns "", then use the default-value instead of the stored one.
  if reaper.MB("Do you really want to reset your settings to the factory default-settings?", "Reset to defaults?", 4)==6 then
    reaper.DeleteExtState("LeaFac_OBS", "Address", true)
    reaper.DeleteExtState("LeaFac_OBS", "Password", true)
    reaper.DeleteExtState("LeaFac_OBS", "Extension", true)
    reaper.DeleteExtState("LeaFac_OBS", "Latency", true) 
    reaper.DeleteExtState("LeaFac_OBS", "TRACK_NAME", true)
    reaper.DeleteExtState("LeaFac_OBS", "ALWAYS_CREATE_NEW_TRACK", true)
    reaper.DeleteExtState("LeaFac_OBS", "Subfolder", true)
    reaper.DeleteExtState("LeaFac_OBS", "EXECUTE_TIMEOUT", true)
    reaper.DeleteExtState("LeaFac_OBS", "OBS_STOP_RECORDING_TIMEOUT", true)
  end
end

function QuitMe() 
  -- this function quits the script
  dockstate, x,y,w,h=gfx.dock(-1,0,0,0,0)
  --reaper.MB(x.." "..y.."\n"..x2.." "..y2, "",0)
  reaper.SetExtState("LeaFac_OBS", "prefs_x", x, true)
  reaper.SetExtState("LeaFac_OBS", "prefs_y", y, true)
  
  gfx.quit()
end



-- [[ GUI-element-functions ]]

-- here come the GUI-element functions. If you want to add another GUI-element into the preferences, just use one of these
-- functions to do it.
-- For those elements who can store stuff, you can set a section and key, into which the settings will be stored.
-- They are then stored as ExtStates using SetExtState. To retrieve these settings, use GetExtState in your script.
-- As "section" I used "LeaFac_OBS", and as key the name of the setting.
-- Set some of the values and have a look into reaper-extstate.ini to see, how this looks like. You quickly get the idea.
--
-- Important: it will NOT store them, when nothing has been clicked. So you need to have default-values in your
--            script, in case the user hasn't set any settings yet(in that case, GetExtState returns ""
--            The values returned by GetExtState are always strings, so integers and such must be converted
--            using integervalue=tonumber(value)

-- Now, all functions and an explanation, what they do, how and where they store the settings.
-- Also an explanation of the parameters.

function ManageCheckBox(x, y, section, key, default)
  -- This adds a checkbox. If that checkbox is clicked it will store a 1 into the extstate.
  -- Parameters:
  --            integer x - the x-position in pixels
  --            integer y - the x-position in pixels
  --            string section - the section, in which it's statechanges shall be stored(for instance LeaFac_OBS)
  --            string key - an explanatory name for the key, in which the value will be stored.
  --            boolean default - if no value is set until now, you can set this to a default in the checkbox to true(checked) or false(unchecked)
  
  local value=tonumber(reaper.GetExtState(section, key))
  if clickstate==true and 
    gfx.mouse_x>=x and gfx.mouse_x<=x+20 and 
    gfx.mouse_y>=y and gfx.mouse_y<=y+20
    then
    if value==1 then
      reaper.SetExtState(section, key, 0, true)
      value=0
    else
      reaper.SetExtState(section, key, 1, true)
      value=1
    end
  end
  if default==false then default=0 else default=1 end
  if value==nil then value=tonumber(default)  end
  
  gfx.set(0.8)
  gfx.rect(x,y,20,20,0)
  gfx.set(1,1,0)
  if value==1 then gfx.rect(x+5, y+5, 10, 10, 1) end
end



function DrawText(x, y, text, mode, tooltip, size)
  -- This displays a text and optionally allows showing a tooltip
  -- Parameters:
  --            integer x - the x-position in pixels
  --            integer y - the x-position in pixels
  --            string text - the text, that shall be shown
  --            integer mode - refer gfx.mode for this value
  --            string tooltip - when mouse hovers over text, show this as a tooltip
  --            integer size - the font-size of the text; omit it to use the default one
  --                         - remember, that fontsize on Mac is not the same on Windows.
  --                         - which means, these must be set for both systems individually.
 if size==nil then 
  size=17
  if not string.match( reaper.GetOS(), "Win") then
     size = math.floor(size * 0.8)
   end
 end
 if mode==nil then mode=0 end
  gfx.set(0.8)
  gfx.x=x
  gfx.y=y
  gfx.setfont(1, "Arial", size, mode)
  gfx.drawstr(text)
  gfx.setfont(1, "Arial", size, 0)
  
  if tooltip~=nil and ShowToolTip==true and ToolTipShown==false and 
    gfx.mouse_x>=x and gfx.mouse_x<=x+gfx.measurestr(text) and
    gfx.mouse_y>=y and gfx.mouse_y<=y+gfx.texth then
    ALLAAAA=os.date()
    local X,Y=reaper.GetMousePosition()
    reaper.TrackCtl_SetToolTip(tooltip, X+15, Y, true) 
    ToolTipShown=true
  end
  mode=oldmode
end

function InputText(x, y, width, section, key, default, InputTitle, InputText, onlynumbers)
  -- This adds a textbox, which, when clicked, opens an input-dialog, into which one can enter the new value.
  -- This value will then be stored as extstate.
  -- If the text exceeds the size of the inputbox, it will be truncated visually. To show the entire text,
  -- just hover above the inputbox and it will show it via tooltip.
  
  -- Parameters:
  --            integer x - the x-position in pixels
  --            integer y - the x-position in pixels
  --            integer width - the shown width of the text-box; shown text might be t
  --            string section - the section, in which it's statechanges shall be stored(for instance LeaFac_OBS)
  --            string key - an explanatory name for the key, in which the value will be stored.
  --            string default - if no value is set until now, you can set this to a default in the inputfield
  --            string InputTitle - this will influence the title of the input-dialog
  --            string InputText - this will influence the text, next to the input-box in the input-dialog
  --            boolean onlynumbers - true, allows only entering numbers; false or nil, any text can be entered

  local value=reaper.GetExtState(section, key)
  if value=="" then value=default end
  if gfx.mouse_x>=x and gfx.mouse_x<=gfx.w-10 and 
     gfx.mouse_y>=y and gfx.mouse_y<=y+20
    then
    if clickstate==true then
      retval, enteredtext = reaper.GetUserInputs(InputTitle, 1, InputText..",extrawidth=150", value)
      if retval==true then
        if onlynumbers==true and tonumber(enteredtext)==nil then
          reaper.MB("Only numbers can be entered in this field!", "Only numbers", 0)
          enteredtext=value
        else
          reaper.SetExtState(section, key, enteredtext, true)
        end
        value=enteredtext
      end
    else
      if ShowToolTip==true and ToolTipShown==false then
        local X,Y = reaper.GetMousePosition()
        reaper.TrackCtl_SetToolTip(value, X+10, Y, true)
        ToolTipShown=true
      end
    end
  end
  gfx.x=x+2
  gfx.y=y+1
  gfx.set(0.17)
  gfx.rect(x-2,y,width,gfx.texth+1,1)
  gfx.set(0.3)
  gfx.rect(x,y+2,width,gfx.texth+1,0)
  gfx.set(0.8)
  gfx.rect(x-1,y+1,width,gfx.texth+1,0)
  gfx.drawstr(value, 0, width+x, y+gfx.texth+1)
end

function ManageButton(x, y, buttontext, functioncall)
  -- This adds a button, which can be clicked on.
  -- As you might want to have additional functionality associated with that button,
  -- you can write a function that does, what you want. Then pass the name of the function
  -- as parameter functioncall and this function will run it, everytime the button was clicked
  
  -- Parameters:
  --            integer x - the x-position in pixels
  --            integer y - the x-position in pixels
  --            string buttontext - the text of the button
  --            function functioncall - the name of the function that shall be called. Just as it is, NOT as string!
  local clickoffset=0
  local width=gfx.measurestr(buttontext)+20
  if gfx.mouse_cap&1==1 and gfx.mouse_x>=x and gfx.mouse_x<=x+width and 
     gfx.mouse_y>=y and gfx.mouse_y<=y+20
    then
    clickoffset=2
  end

  gfx.set(0.8)
  
  local h=gfx.texth+4
  local r=2
  -- draw roundrectangle(code taken from Lokasenna's Gui Lib, inspired by mwe's EEL-sample
  gfx.set(0)
  x=x+clickoffset
  y=y+clickoffset
  -- Corners
  gfx.circle(x + r,         y + r    , r, 1, aa)      -- top-left
  gfx.circle(x + width - r, y + r    , r, 1, aa)      -- top-right
  gfx.circle(x + width - r, y + h - r, r, 1, aa)      -- bottom-right
  gfx.circle(x + r,         y + h - r, r, 1, aa)      -- bottom-left
  -- Ends
  gfx.rect(x, y + r, r, h - r * 2)
  gfx.rect(x + width - r, y + r, r + 1, h - r * 2)
  -- Body + sides
  gfx.rect(x + r, y, width - r * 2, h + 1)
  
  gfx.set(0.3)
  x=x+1
  y=y+1
  -- Corners
  gfx.circle(x + r,         y + r    , r, 1, aa)      -- top-left
  gfx.circle(x + width - r, y + r    , r, 1, aa)      -- top-right
  gfx.circle(x + width - r, y + h - r, r, 1, aa)      -- bottom-right
  gfx.circle(x + r,         y + h - r, r, 1, aa)      -- bottom-left
  -- Ends
  gfx.rect(x, y + r, r, h - r * 2)
  gfx.rect(x + width - r, y + r, r + 1, h - r * 2)
  -- Body + sides
  gfx.rect(x + r, y, width - r * 2, h + 1)

  gfx.set(0.3)
  x=x-clickoffset-1
  y=y-clickoffset-1
  
  gfx.x=x+clickoffset*2
  gfx.y=y+clickoffset+2
  gfx.set(0)
  gfx.drawstr(buttontext, 1, width+x+2, y+gfx.texth+4)
  gfx.x=x+clickoffset*2
  gfx.y=y+clickoffset+3
  gfx.set(0.8)
  gfx.drawstr(buttontext, 1, width+x+3, y+gfx.texth+6)

  if gfx.mouse_cap&1==0 and OldCap2==1 and 
     gfx.mouse_x>=x and gfx.mouse_x<=x+width and 
     gfx.mouse_y>=y and gfx.mouse_y<=y+20 then
     functioncall()
  end
end  


-- [[ Initialization of the GUI-Window and some management functions]]
-- You can mostly ignore the following functions, as they do some management here and there.
-- So best is to leave them untouched.

-- Initialize window and some global variables; leave them untouched
Val=tonumber(reaper.GetExtState("LeaFac_OBS", "prefs_x")) if Val~=nil then WindowX=Val end
Val=tonumber(reaper.GetExtState("LeaFac_OBS", "prefs_y")) if Val~=nil then WindowY=Val end

gfx.init("LeaFac-OBS - Preferences", WindowWidth, WindowHeight, 0, WindowX, WindowY)
OldCap=0
OldCap2=0
size=17
if not string.match( reaper.GetOS(), "Win") then
   -- font-size-management on non-Windows-systems, so the font is properly scaled
   size = math.floor(size * 0.8)
end
gfx.setfont(1, "Arial", size, 0)
ToolTipCount=0

function GetMouseState()
  -- This does some mouse-stuff checking and the measuring ot the waittime, until tooltips are shown.
  -- Just leave it as it is.
  if OldMouseX==gfx.mouse_x and OldMouseY==gfx.mouse_y then 
    ToolTipCount=ToolTipCount+1
    if ToolTipCount>ToolTipWaitTime then
      ShowToolTip=true
    else
      ShowToolTip=false
      ToolTipShown=false
    end
  else
    ToolTipCount=0
    reaper.TrackCtl_SetToolTip("", 1, 1, true) 
  end
  OldMouseX=gfx.mouse_x
  OldMouseY=gfx.mouse_y

  -- this returns, if the left-mousebutton has been clicked.
  -- this is used in the main-function. Just leave it there and use its returnvalue, where needed.
  if gfx.mouse_cap&1==1 and OldCap==0 then OldCap=1 return true end
  if gfx.mouse_cap&1==0 and OldCap==1 then OldCap=0 end

  return false
end

function RefreshWindow()
  -- In here, I reset the window for further drawing operations, as well as checking, whether the user hit
  -- enter or esc to close the window.
  -- Just leave it as it is.
  Y=YDefault
  gfx.set(0.1)
  gfx.rect(0,0, gfx.w, gfx.h)
  clickstate=GetMouseState() -- get the clickstate, as needed by several functions
  Key=gfx.getchar()
  if Key==13 or Key==27 then QuitMe() end
  main()
end

RefreshWindow() -- start the magic
