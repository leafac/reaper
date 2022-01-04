<!--
Prepare project for video/audio editing: Set BPM to 240 so 1 measure is one second. (See comment on https://reaperblog.net/2017/02/custom-grid-size-toolbar/)



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
