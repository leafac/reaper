<h1 align="center">Leandro Facchinetti’s REAPER Effects and Scripts</h1>

## How to Install

Add the following repository to [ReaPack](https://reapack.com):

```
https://github.com/leafac/reaper/raw/master/index.xml
```

If you’re new to this, check [this video](https://youtu.be/gVbMbqGSB7E) (in particular, 11:26).

## Automixer

<h3 align="center"><a href="https://youtu.be/qi1jQcIaOxo">Watch a video with a demonstration and instructions</a></h3>

[Example project](https://archive.org/download/leafac/leafac_Automixer%20Examples.zip)

[Automixer video editor FX Chain](effects/leafac_Automixer%20video%20editor.RfxChain)

More information:

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

| Extension                                                                                               | Author                                                          | Repository Index URL                                                           |
| ------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| **All**                                                                                                 |                                                                 | `https://github.com/leafac/reaper/raw/master/third-party/index.xml`            |
| [SWS](http://sws-extension.org) (For macOS. UserPlugin only, no Python, no Grooves.)                    |                                                                 | `https://github.com/leafac/reaper/raw/master/third-party/sws/sws.xml`          |
| [ReEQ and ReSpectrum](https://forum.cockos.com/showthread.php?t=213501)                                 | [nitsuj](https://forum.cockos.com/member.php?u=121300)          | `https://github.com/leafac/reaper/raw/master/third-party/reeq/index.xml`       |
| [ABLevelMatching, AutoGainStaging, and EBUR128LM](https://www.tb-software.com/TBProAudio/download.html) | [TBProAudio](https://www.tb-software.com/TBProAudio/index.html) | `https://github.com/leafac/reaper/raw/master/third-party/tbproaudio/index.xml` |
