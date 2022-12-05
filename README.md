<!--
Bug in Scripts/leafac_Explode multistream (multitrack) media file to new one-stream (one-track) media files.lua:
Streams may be something other than video or audio. They may also be subtitles, attachments (data), and so forth. Right now, the script will try to treat them as audio and crash. These other streams should probably be ignored. (Report back to Ockenden)





Image to MIDI conversion


Maybe multichannel is bad because it affects Sidechains for later plugins
Test what denormalization is doing: adding noise (like dither) or a fixed small value (like ReEQ)
On rms, don’t compute the root and convert to db directly
Generate pink noise with stochastic model: inverse fft of magnitude with 3db slope and random phase
Waveform visualizer for any plug-in (just sandwich)
Yin
Plugin doctor
Idea of how to make circular buffers faster: have a notion of item size, so that you can store structs directly and cut one memory dereference
Idea pf optmization for rms: dont store the size, store its reciprocal, so that a division turns into a multiplication 
just call getchar so that mouse modifiers work
Digital hardware (like lexicon) has adc and dac. So if you have several in the chain, doesn’t it mean a lot of latency? What about modular synths?


Draw a piano keyboard 
Frequency to midi note and back
What does spectral reversal sound like (not applied to a filter kernel, but to a signal)
Correlation meter


Ping pong ball drop https://www.youtube.com/watch?app=desktop&v=ZGcpOFo_HDA


Use “play or stop” on MIDI editor


ADD TO REAPACK

leafac_Unselect (clear selection of) all tracks, items, envelope points, time selection, and loop points


MAP

esc: leafac_Unselect (clear selection of) all tracks, items, envelope points, time selection, and loop points





Prepare project for video/audio editing: Set BPM to 240 so 1 measure is one second. (See comment on https://reaperblog.net/2017/02/custom-grid-size-toolbar/)


Leslie https://www.youtube.com/watch?v=vUaScoPXW28



Controlling REAPER with AutoHotkey

- [ ] https://www.youtube.com/watch?v=ipL7H02G8bs&lc=UgzfLHisYi3GLBVVCUl4AaABAg


- [ ] OBS ↔ REAPER
    - [ ] Abort recording & pre-roll & stuff: https://forum.cockos.com/showthread.php?p=2455092#post2455092


REAPER ↔ OBS

- [ ] Abort recording: https://forum.cockos.com/showpost.php?p=2430380&postcount=29
- [ ] Don’t show user-generated values in GetUserInputs, use ShowConsoleMsg instead
    - [ ] You would need to add a short reference to the console-window in the title of GetUserInputs, so blind people know, there's a second window to look for additional information.
- [ ] Use Mespotine’s scripts
- [ ] LTC
    - [ ] https://www.youtube.com/watch?v=E4R4wlfKdcw&lc=UgxRZeB539r1oGd__lt4AaABAg
- [ ] Add better error messages:
    - [ ] When OBS isn’t running
    - [ ] When you’re already recording and try to start
    - [ ] When you’re not recording and try to stop
    - [ ] https://www.youtube.com/watch?v=dxfM4ftB1hM&lc=UgyzzfiAV-l2CMDhUF14AaABAg
- [ ] Pre-roll/count-in/loop recording: https://forum.cockos.com/showpost.php?p=2421273&postcount=27
- [ ] Don’t change the recording path in OBS https://forum.cockos.com/showpost.php?p=2476104&postcount=8
- [ ] Add as a new take, not new track (Adding the video as a new take to an item if there is already a video recorded there.) https://forum.cockos.com/showpost.php?p=2476736&postcount=44 / stefhambrook@gmail.com
- [ ] Cancel recording (and discard audio and video files into the trash)  triode
- [ ] Multicam OBS with multiple OBS instances https://www.youtube.com/watch?v=E4R4wlfKdcw&lc=UgyS-NHJoZkEdwLFj3N4AaABAg

- [ ] Add YouTube links to ReaScripts


JSFX

- [ ] Ping-pong delay
- [ ] Detect chords
- [ ] Blow air into mic game
- [ ] Flappy bird game (Flappy Square)
- [ ] Airwindows: Convert to JSFX: Spiral or Mojo
- Focus, an all-in-one distortion suite that includes, among others, the Spiral and Mojo algorithms (you may also try Distortion, which is pretty similar except without the frequency selection)
- PurestGain, as JSFX's ability to type exact values would work wonders on this
- Preponderant, a plugin that does the opposite of popular resonance-removing plugins like Soothe, TEOTE and the freeware Vastaus (we need to implement an "Inverse" function in the Dry/Wet just like in other Airwindows plugins, so it does actually function as a Soothe-like plugin)
- DeBess, as it is an excellent de-esser but its structure may not be easy to understand for beginners (same with Pressure4)
- Infinity2 (so you can kill the feedback with a button instead of dragging the Feedback fader to the left)
- CStrip may be good for JSFX, and I'd like to try its TimeLag function with exact values
Fotis Ky <seethisworld@gmail.com>


- [ ] Control dry/wet depending on gain (think about how reverb works in a hall: louder means more reverb)
- [ ] Fernando Imperator (https://twitter.com/imperat) Feature idea: If you ever develop a version that instead of rendering the multicam video, just creates an XML to import to Adobe Premiere or DaVinci, it'd be awesome.

- [ ] Run Doom in JSFX

Scripts

- [ ] That ADR item naming thing

A VST that connects to WebRTC

- [ ] https://forum.cockos.com/private.php?do=showpm&pmid=205857
- [ ] Re: Build a jsfx plugin question
- [ ] https://forum.cockos.com/showthread.php?t=249449
- [ ] https://sonobus.net
- [ ] https://audiomovers.com/wp/
- [ ] https://www.landr.com/en/sessions


- [ ] Use reaper.GetCursorContext() to create ReaScript that consolidates Item: Duplicate items and Track: Duplicate tracks
- [ ] Upload rendered video to YouTube
- [ ] Sync footage
- [ ] Multicam
    - [ ] Create ReaScripts to switch items on a dedicated track: https://www.youtube.com/watch?v=1BvuRgKNnqc&lc=UgxKIx95LJ9-nLCd-5d4AaABAg
    - [ ] ReaScript to set up tracks & dedicated video processor item
    - [ ] Add support for clicking on thumbnails in preview to switch to another scene
    - [ ] When switching with ReaScript if you didn’t select items, look for an item under the cursor (and maybe even if you did select items, really)


- [ ] Structured data
    - [ ] Structures
        - [ ] Arrays
        - [ ] Objects
        - [ ] Multi-dimensional arrays
            - [ ] For example, lists of one buffer per channel
        - [ ] Circular buffers
            - [ ] One field for current position, another for buffer itself
    - [ ] Uses
    - [ ] Applications
        - [ ] Automixer
        - [ ] Oscilloscope
    - [ ] Implementation techniques
        - [ ] Pseudo-objects
            - [ ] Good because it puts together things that belong together
            - [ ] Bad because it doesn’t work with dynamically allocated structures (for example, one circular buffer per channel)
        - [ ] Arrays with fixed positions (for example, my_object[field_index], my_multi_dimensional_array[index_x][index_y])
        - [ ] Functions that calculate indexes (for example, my_multi_dimensional_array[my_multi_dimensional_array_index(x, y, width, height)]
            - [ ] Good because multiplication is faster than multiple memory lookups of the technique above
            - [ ] Bad because it’s more cumbersome to use (you have to keep repeating the width and height, but it may be a good thing to avoid out-of-bounds errors)
function begin_memory_allocation() global(next_available_memory_address) (
  next_available_memory_address = 0;
);
function array(size) local(address) global(next_available_memory_address) (
  address = next_available_memory_address;
  next_available_memory_address += size;
  address;
);
function end_memory_allocation() global(next_available_memory_address) (
  freembuf(next_available_memory_address + 1);
);

begin_memory_allocation();
buffer1 = array(100);
buffer1[20] = array(20);
buffer2 = array(200);
end_memory_allocation();
- [ ] Better tooling
    - [ ] Formatter
    - [ ] Visual Studio Code support
        - [ ] Syntax highlighter
        - [ ] Refactoring tools
    - [ ] Unit tests
        - [ ] Null tests

Automixer

- https://forums.prosoundweb.com/index.php/topic,158018.0.html
- https://forum.audulus.com/t/gain-sharing-auto-mixer/1744
- [ ] Plugin Delay Compensation should be 0 samples when there’s no lookahead (hard-code a special case)
- [ ] max(gain reduction with lookahead, gain reduction without lookahead) https://www.youtube.com/watch?v=p7Ol5FPvHfs
- [ ] Draw dB scale on meters
- [ ] Envelope (Attack, Hold, Release)
- [ ] More appealing visuals
    - [ ] Background
    - [ ] Title

- [ ] Tone generator: Part 3
    - [ ] Invert square wave
    - [ ] Refactor the thing that draws on Y axis
    - [ ] LFO controls
        - [ ] Test with enveloper
    - [ ] Mention frequency bound problem
- [ ] Hull Moving Average as a low-pass filter
- [ ] Hilbert curve
- [ ] Flappy Bird controlled by voice!
- [ ] Shepard’s tone generator
- [ ] NES emulation
    - [ ] Load ROM as audio!
- [ ] A Vocal Rider clone
- [ ] Sound visualizations
- [ ] DC offset fixer
- [ ] LV2 effect: https://news.ycombinator.com/item?id=25046869
- [ ] Oscilloscope
    - [ ] Plot channels as a stack of oscilloscopes (that’s what the main REAPER interface does)
    - [ ] Draw scale
- [ ] GUI knob: https://forum.cockos.com/showpost.php?p=2357022&postcount=3
- [ ] Delay
    - [ ] Ping-pong
- [ ] Subsampler (a digital distortion effect that consists of reducing the number of samples per second)
    - [ ] Use it for aliasing distortion: https://www.youtube.com/watch?v=74GzXK1MngI
- [ ] Volume meter
- [ ] Tuner
- [ ] Metronome
- [ ] Pitch shifter
- [ ] Vectorscope (ginioscope)
- [ ] Phase shifte
- [ ] Tone Generator
    - [ ] Noise
        - [ ] White
        - [ ] Pink
            - [ ] https://www.firstpr.com.au/dsp/pink-noise/
            - [ ] https://dsp.stackexchange.com/questions/62342/understanding-voss-mccartney-pink-noise-generation-algorithm
            - [ ] 
        - [ ] Brown
        - [ ] Gray
    - [ ] Sample and hold
    - [ ] Truncate the shapes above
    - [ ] ASDR (use trigger)
    - [ ] User-drawn shapes
    - [ ] LFO mode
- [ ] White noise, when speed up, doesn’t sound a different pitch and tamber (it’s a fucking fractal!)
    - [ ] Generate white and brown music with MIDI
    - [ ] Stochastic method
    - [ ] Build arpeggiators with these
    - [ ] Pink noise: levels of river!
    - [ ] White: sum 10 dice / brown: up on even, down on odd / pink: three dice rolled on log_2
    - [ ] How do different colors of sound feel with hands on the speakers
- [ ] Subtractive synth
    - [ ] ADSR
    - [ ] MIDI
- [ ] Granular synth
- [ ] Meters
    - [ ] Peak
    - [ ] RMS
    - [ ] LUFS
        - [ ] Seems to be a combination of RMS + gating + a-weighting
        - [ ] Check EBU manuals to learn more about it
    - [ ] PSR and PLR
        - [ ] http://www.meterplugs.com/blog/2017/05/18/crest-factor-psr-and-plr.html
        - [ ] http://www.meterplugs.com/blog/2016/11/18/why-loudness-doesnt-matter.html
        - [ ] Dear Leandro
- [ ] Levels over time
    - [ ] Peak
    - [ ] RMS
    - [ ] LUFS
- [ ] Pitch shifter
- [ ] EQ
    - [ ] A low-pass filter is like lowering the sample rate 🤯
    - [ ] What are poles and zeroes?
- [ ] Compressor
- [ ] Limiter
    - [ ] Soft clipper
    - [ ] Peak limiter
- [ ] Telephoner: a one knob FX that’s a bit crusher followed by a filter
- [ ] Tremolo
    - [ ] Combination of an LFO with an Enveloper
- [ ] Reverb
    - [ ] Algorithmic
    - [ ] Convolution
- [ ] Spectogram
- [ ] Spectrograph
- [ ] De-click
- [ ] De-plosive
- [ ] Crazy ideas:
    - [ ] Multichannel mid-side
    - [ ] Generate noises (white, pink, and so forth) by inverse FFT of random frequencies with right slope
    - [ ] Generate pink noise with a variation of the standard algorithm: Generate the random number that you need to update every sample anyway; now if it’s between 0 and 0.5, update octave 1; if it’s between 0.5 and 0.75 update octave 2, and so forth (this may be stochastic method)
- [ ] Other topics to cover:
    - [ ] Even when you’re clipping in the middle of a FX chain, or in a channel, there’s a chance that you won’t clip in the end, of somewhere in the pipeline there’s another thing that brings the gain down
        - [ ] That works because internally REAPER (and many other DAWs) use 64 bits per sample, as opposed to the 16/24/32 that you’d find in other places
        - [ ] But it’s generally a bad idea to rely on this, because some effects don’t work as well when the input is clipping
        - [ ] When writing JSFX, this means that sometimes your samples won’t be in the –1 - 1 range
    - [ ] The notions of dB in different scales
        - [ ] dBFS (Full scale)
            - [ ] –∞ - 0
            - [ ] DAWs
        - [ ] dBSPL (Sound pressure levels)
            - [ ] 0 - ∞
        - [ ] VU
            - [ ] Old hardware
            - [ ] 0 is optimal operation level, which corresponds to around –18dBFS
    - [ ] Planning laws


Mid panner https://youtu.be/upG1KaKExMY



 The first idea is a script that would open a dialog box in REAPER. In the dialogue box, you can enter a shortcut or simply paste a command ID, and in the first case, it would look for the command ID with that shortcut assigned to it, and in the second case it would just use the ID to generate a smart marker at edit cursor position. Currently there is an outboarder script that allows making a custom name and color marker, but all the modifications needs to be done by duplicating the script and editing values in the IDE, so I thought It'd be cool if there was a way of to have a dialog box basically kinda fill in those strings. That way it could be a hotkey or toolbar icon and it would quickly generate a bunch of action markers even by hotkey inputs.

  It would be nice if there was a script in REAPER that would generate an ADR script from a list of item names. The studio I used to work in had a similar setup for Pro Tools, where you would make clip regions, and then export a text file from Pro Tools. It would have the start timecode and the name of the clip region, which you would then paste into an excel sheet, and it would generate a script based on that. I'll have to dig it up but basically let me know if any of this sounds like something you'd be interested in and we can keep communicating from there!


   Basically it would be an action to write the volume/pan/pitch envelope of a track onto the items that are on the track. It's really useful in films cuz the sound editor usually doesn't do automation and the mixer does, so with this script, the sound designer can mix their own reaper project, and then in the end just write all of the automation to the items, and they can then just clear all the track envelopes and the project is ready to mix. 

 It'll be useful for other people too cuz track envelopes have a lot more features overall, like latch preview (items have them but they're a pain and again, way fewer actions to toggle them etc.) and also track envelopes are more straightforward to assign to midi controllers than items (speaking of which, action to assign midi cc to "selected items volume" is useful too and I think that one doesn't exist either) but then writing all that to the item frees up the envelope lanes once again, and also items can then be freely position across tracks.


 Scripts/leafac_Explode multistream (multitrack) media file to new one-stream (one-track) media files.lua: copy name from original takes, just like we already copy the name from original tracks: Fotis Ky




 A delay plugin in which you can route anything into the feedback chain by using a non-causal loop in a sandwich of effects.









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

-->

<h1 align="center">Leandro Facchinetti’s REAPER Effects and Scripts</h1>

## How to Install

Add the following repository to [ReaPack](https://reapack.com):

```
https://github.com/leafac/reaper/raw/main/index.xml
```

If you’re new to this, check [this video](https://youtu.be/gVbMbqGSB7E) (in particular, 11:26).

## Multicam Editing

<h3 align="center"><a href="https://youtu.be/1BvuRgKNnqc">Watch the video with a demonstration and instructions!</a></h3>

Install the FX Chains:

- [`FXChains/leafac_Video processor - Multicam - Preview.RfxChain`](FXChains/leafac_Video%20processor%20-%20Multicam%20-%20Preview.RfxChain)
- [`FXChains/leafac_Video processor - Multicam - Selector.RfxChain`](FXChains/leafac_Video%20processor%20-%20Multicam%20-%20Selector.RfxChain)

## Automixer

<h3 align="center">Watch the videos with demonstrations and instructions!</h3>

- [Quick start](https://youtu.be/hSnk6ueU3hQ).
- [Main features](https://youtu.be/qi1jQcIaOxo).
- [Automixer video editor](https://youtu.be/aEvO3ufOqvY).

See also:

- [Code review](https://youtu.be/7V2dGYGtV-8).
- [Example projects](https://archive.org/download/leafac/leafac_Automixer%20Examples.zip).
- [Automixer video editor FX Chain](FXChains/leafac_Video%20processor%20-%20Automixer.RfxChain).

Even more information:

- Alternatives:
  - [The original REAPER JSFX extension on which this is based](https://forum.cockos.com/showthread.php?t=173289). It doesn’t have as many features (for example, track priorities), and is more prone to bugs because it relies on inter-plugin communication. But it’s easier to setup for simple cases and it supports projects with massive numbers of tracks, while this modification is limited by the 64 channels per track that REAPER offers.
  - [TBProAudio’s AMM Automatic Microphone Mixer](https://www.tb-software.com/TBProAudio/amm.html). It’s limited to 16 stereo tracks and requires a setup with transmitters and receiver plugin instances, which limits the possibility of having independent groups of automixed tracks.
  - [WTAUTOMIXER](https://www.wtautomixer.com).
  - [Waves Dan Dugan Automixer Plugin](https://www.waves.com/plugins/dugan-automixer). This only works on Waves MultiRack system, not as a regular audio plugin.
- Papers on Automixers:
  - [Real-Time Multi-Track Mixing For Live Performance](https://zenodo.org/record/2550903#.X43irC9h01I).
  - [Automatic Microphone Mixer White Paper](https://jp.yamaha.com/files/download/other_assets/7/329527/Automixer_WhitePaper_en.pdf).
  - [The original patent](https://worldwide.espacenet.com/publicationDetails/originalDocument?CC=US&NR=3992584A&KC=A&FT=D&ND=&date=19761116&DB=&locale=en_EP). This patent has expired, and since then the Automixer is also known as a **gain sharing algorithm**.
  - [An article explaining how to Automixer works on a high level](http://www.protechaudio.com/products/PDFFiles/DuganMixing.pdf).
- How I learned about Automixing:
  - [Podigy’s Complete Guide to Podcast Editing](https://podigy.co/podcast-editing-guide/). This where I first read about Automixing and became obsessed with the topic.
  - [An interview on the Podcast Engineering School with Dan Dugan, the inventor of the Automixer](https://podcastengineeringschool.com/dan-dugan-inventor-of-the-automatic-microphone-mixer-pes-101/).

## Third-Party ReaPack Redistribution

| Extension                                                                                               | Author                                                                        | Repository Index URL                                                          |
| ------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| **All**                                                                                                 |                                                                               | `https://github.com/leafac/reaper/raw/main/ThirdParty/index.xml`            |
| [SWS](http://sws-extension.org)                                                                         | [The SWS Contributors](https://github.com/reaper-oss/sws/graphs/contributors) | `https://github.com/leafac/reaper/raw/main/ThirdParty/SWS/index.xml`        |
| [ReEQ and ReSpectrum](https://forum.cockos.com/showthread.php?t=213501)                                 | [nitsuj](https://forum.cockos.com/member.php?u=121300)                        | `https://github.com/leafac/reaper/raw/main/ThirdParty/ReEQ/index.xml`       |
| [ABLevelMatching, AutoGainStaging, and EBUR128LM](https://www.tb-software.com/TBProAudio/download.html) | [TBProAudio](https://www.tb-software.com/TBProAudio/index.html)               | `https://github.com/leafac/reaper/raw/main/ThirdParty/TBProAudio/index.xml` |
