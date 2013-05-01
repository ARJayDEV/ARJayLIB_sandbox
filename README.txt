==========================================
ARJAY ARMA 3 editing testing mission
==========================================

A mission for ARMA 3 alpha testing editing and scripting.
Consists of libraries of wrapper methods to familiarise myself
with ARMA scripting and editing options. I have compiled
examples and features from online tutorials and the bohemia docs.

INSTALLATION
------------------------------------------------------

grab the mission from github: https://github.com/ARJayDEV/ARJayLIB_sandbox

Copy the arjay folder into your mission.

Include the entire library by placing the following in your init.sqf

#include "arjay\arjay_kickstart.sqf"

Alternatively you can add only the library scripts you need for example

#include "arjay\arjay_util.sqf"


GETTING STARTED WITH A3 SCRIPTING
------------------------------------------------------

Use the resources listed below! 

Download baretail log viewer and point it at the arma3.rpt file (user/AppData/Local/Arma 3 Alpha/arma3.rpt), 
leave the file open and watch script errors, debugging dumps live as they occur.

Make use of arjay_dump and arjay_inspect dev tools to keep an eye on objects and variables in game.

RESOURCES USED
------------------------------------------------------

http://community.bistudio.com/wiki/Category:Scripting_Commands_ArmA
http://community.bistudio.com/wiki/Category:Arma_3:_New_Scripting_Commands_List
http://browser.six-projects.net/cfg_weapons/classlist?version=67
http://browser.six-projects.net/cfg_vehicles/classlist?version=67
http://www.antihelios.de/EK/Arma/index.htm
http://forums.bistudio.com/forumdisplay.php?169-ARMA-3-ALPHA-EDITING
http://forums.bistudio.com/forumdisplay.php?70-ARMA-MISSION-EDITING-amp-SCRIPTING
http://www.ofpec.com/forum/
http://www.armaholic.com/forums.php?m=topics&s=166
http://www.armaholic.com/forums.php?m=topics&s=165
http://www.reddit.com/r/armadev
http://www.ofpec.com/COMREF/index.php?action=read&id=231
http://tactical.nekromantix.com/wiki/doku.php?id=arma2
http://www.youtube.com/playlist?list=PLRQhbizmrQaU5ET8OQ-n4ZT8Y_PWAyD3X
http://www.youtube.com/user/OksmanToH?feature=watch


TOOLS USED
------------------------------------------------------

http://www.kegetys.fi/arma/
http://community.bistudio.com/wiki/BI_Tools_2.5
http://www.baremetalsoft.com/baretail/
http://www.armedassault.info/index.php?game=1&cat=news&id=2670

WITH THANKS
------------------------------------------------------

To the awesome community, who have already answered most of my questions
at some point in the long history of arma modding and scripting. In particular to:
armaholic staff for curating a heap of content and posts
bi forum staff for the same
kylania for some great more advanced code snippets and forum responses
zemek kondor for the marker tracking script
Tonic for the ammo box filler
Sickboy for his class reference browser

Anyone who answered in the following threads
http://forums.bistudio.com/showthread.php?152788-Building-unique-identifiers-I-feel-like-I-m-missing-something-fundamental

And to BI who have made an open and exciting world allowing creativity and mayhem!

FILES
------------------------------------------------------

description.ext
Lifted from alpha infantry mission
Handles loading titles etc
See http://community.bistudio.com/wiki/Description.ext

init.sqf
Starts the ball rolling
Preprocesses arjay libs for inclusion
Includes briefing and mission init files

initBriefing.hpp
Lifted from alpha infantry mission
Briefing Setup

initMission.hpp
Lifted from alpha infantry mission
SITREP UAV setup
General mission setup

mission.sqm 
The mission

stringtable.csv 
Text localization and settings for conversations

conversation/test_conversation.bikb
Test conversation sounds / text

conversation/test_conversation_target1.fsm
Test conversation AI conversation finite state machine

conversation/test_conversation_player.fsm
Test conversation player conversation options

arjay/arjay_kickstart.sqf
Loads all arjay library files, called from init.sqf

arjay/arjay_announce.sqf
UI methods for displaying information to the player. 

arjay/arjay_camera.sqf
Camera handling with common cinemtic shots defined

arjay/arjay_effect.sqf
Post processing and other effects

arjay/arjay_environment.sqf
Date and time presets

arjay/arjay_garbage_collection.sqf
Garbage collection on objects based on distance from player/s

arjay/arjay_gear.sqf
Loadout presets and crate filler

arjay/arjay_marker.sqf
Marker creation and marker target tracking

arjay/arjay_monitor.sqf
Main arjay loop, in this case used for garbage collection

arjay/arjay_modify.sqf
Object modification

arjay/arjay_spawn.sqf
Spawn object presets and randomizers

arjay/arjay_task.sqf
Task handling and objective types

arjay/arjay_util.sqf
Debugging and dev tools

arjay/a3_class_names.txt
Listing of current config classes provided by arjay_util

arjay/arjay_function_usage_examples.txt
Usage examples of most functionality of the library

arjay/README.txt
This file