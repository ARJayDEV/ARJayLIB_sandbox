==========================================
arjay_util.sqf
==========================================

// Dump user defined text by default dumps to arma3.rpt
["Dump some text and then flush it, this copies to the clipbord, or other locations depending on preference"] call arjay_dump;[] call arjay_flush;


// Inspect world environment by default dumps to arma3.rpt
[] call arjay_inspectEnvironment;[] call arjay_flush;

// Inspect passed object by default dumps to arma3.rpt
[player] call arjay_inspect;[] call arjay_flush;

// Inspect various config classes by default dumps to arma3.rpt
[] call arjay_inspectClasses;[] call arjay_flush;

// Inspect various config classes with high detail by default dumps to arma3.rpt
[true] call arjay_inspectClasses;[] call arjay_flush;

// Inspect passed object every X seconds by default dumps to arma3.rpt
[player] call arjay_inspectTrack;

// Position data from passed object every X seconds by default dumps to arma3.rpt
[player] call arjay_dumpTrackPosition;


==========================================
arjay_announce.sqf
==========================================

// Display cut text fade in for 1 second, hold for 5 seconds, fade out for 1 second
_nil = [] spawn {["A long time ago in a galaxy far far away...",1,5,1] call arjay_cut;};

// Display title text fade in for 1 second, hold for 5 seconds, fade out for 1 second
_nil = [] spawn {["A long time ago in a galaxy far far away...",1,5,1] call arjay_title;};

// Display info text
["A long time ago in a galaxy far far away..."] call arjay_info;

// Display 3D credits - buggy
[creditsTarget,"A long time ago in a galaxy far far away..."] call arjay_credits;

// Display dynamic text by default center up position / animation
["A long time ago in a galaxy far far away..."] call arjay_dynamicText;

// Display dynamic text bottom up position / animation
["A long time ago in a galaxy far far away...","BOTTOM_DOWN"] call arjay_dynamicText;

// Display dynamic text bottom down position / animation
["A long time ago in a galaxy far far away...","BOTTOM_LEFT_DOWN"] call arjay_dynamicText;

// Display AAN news overlay
["MY HEADLINE","MY BYLINE","My scrolling test is here!"] call arjay_addAANNews;


==========================================
arjay_marker.sqf
==========================================

// Add a marker on the target object using FLAG preset, with no tracking, and label it rabbit 2
[markerTestRabbit2,"FLAG",false,"rabbit 2"] call arjay_addMarker;

// Add a tracking marker to the rabbit (marker moves around map according to target position)
[markerTestRabbit1,"FLAG",true,"rabbit 1"] call arjay_addMarker;

// Remove an added marker
[0] call arjay_removeMarker;


==========================================
arjay_task.sqf
==========================================

// Create a task for the player
[player, "TITLE","DESCRIPTION"] call arjay_createTask;

// Create a task for the player at the passed marker name position, after 5 seconds complete the task
myTask = [player, "TITLE","DESCRIPTION","taskTestingMarker"] call arjay_createTask;
_nil = [] spawn {
	sleep 5;  
	[myTask] call arjay_completeTask;
};

// Create a task for the player at the passed marker name position, after 5 seconds cancel the task
myTask = [player, "TITLE","DESCRIPTION","taskTestingMarker"] call arjay_createTask;  
_nil = [] spawn {
	sleep 5;  
	[myTask] call arjay_cancelTask;
};

// Create a task for the player at the passed marker name position, after 5 seconds fail the task
myTask = [player, "TITLE","DESCRIPTION","taskTestingMarker"] call arjay_createTask;
_nil = [] spawn {
	sleep 5;
	[myTask] call arjay_failTask;
};

/*
Create a task for the player on the passed target object, task is to kill the target.
Once target has been killed, complete the task, then create a new task to kill his friend
Once friend is dead complete the second task
*/
myTask = [player,killTaskTarget1,"Kill The Civillian","Kill The Civillian"] call arjay_createTargetTask;
_nil = [] spawn {     
	waitUntil {!(alive killTaskTarget1)};   
	[myTask] call arjay_completeTask;   
	sleep 1;   
	myTask = [player,killTaskTarget2,"Now kill his friend","Kill The Friend"] call arjay_createTargetTask;   
	waitUntil {!(alive killTaskTarget2)};   
	[myTask] call arjay_completeTask;  
};


==========================================
arjay_gear.sqf
==========================================

// Strip the player object of everything
[player] call arjay_stripLoadout;

// Equip the player with complete loadout (weapons, ammo, uniform, vest, headgear, backpack, items) from preset "B_DIVER"
[player,"B_DIVER"] call arjay_setLoadout;

// Equip the player with complete loadout from preset "CIV3"
[player,"CIV3"] call arjay_setLoadout;

// Equip the player with weapons / ammo only from preset "B_MARKSMAN"
[player,"B_MARKSMAN"] call arjay_setWeaponLoadout;

// Equip the player with uniform / vest/ headgear only from preset "O_SPECIALIST_EXPLOSIVE"
[player,"O_SPECIALIST_EXPLOSIVE"] call arjay_setUniformLoadout;

// Equip the player with backpack only from preset "B_MEDIC"
[player,"B_MEDIC"] call arjay_setUniformLoadout;

// Equip the player with items only from preset "GANGSTER3"
[player,"GANGSTER3"] call arjay_setItemLoadout;

// Fill an ammo box with all available items
[gearBox] call arjay_fillAmmoBox;


==========================================
arjay_effect.sqf
==========================================

// Apply film grain post process effect preset
_nil = ["FILM_GRAIN"] call arjay_applyPostProcessEffect;

// Apply desaturated post process effect preset
_nil = ["DESATURATED"] call arjay_applyPostProcessEffect;

// Apply monochrome post process effect preset
_nil = ["MONOCHROME"] call arjay_applyPostProcessEffect;

// Apply kodak photo post process effect preset
_nil = ["KODAK"] call arjay_applyPostProcessEffect;

// Apply desaturated post process effect preset
_nil = ["DESATURATED"] call arjay_applyPostProcessEffect;

// Remove all post processing effects
_nil = [] call arjay_removePostProcessEffects;


==========================================
arjay_environment.sqf
==========================================

// Set current day (date) to middle of spring
["SPRING"] call arjay_setDay;

// Set current day (date) to middle of winter
["WINTER"] call arjay_setDay;

// Set current day (date) to a full moon night
["FULL_MOON"] call arjay_setDay;

// Set current day (date) to a no moon night
["NO_MOON"] call arjay_setDay;

// Set time of current day to sunrise
["SUNRISE"] call arjay_setTime;

// Set time of current day to midday
["MIDDAY"] call arjay_setTime;

// Set time of current day to sunset
["SUNSET"] call arjay_setTime;

// Set time of current day to midnight
["MIDNIGHT"] call arjay_setTime;


==========================================
arjay_spawn.sqf
==========================================

// Spawn a large smoke shell at target position
[spawnTarget1,"SMOKE_LARGE"] call arjay_spawn;

// Spawn a flare in air at target position
[spawnTarget1,"FLARE_SMALL"] call arjay_spawn;

// Spawn a large missile that strikes target position
[spawnTarget1,"MISSILE_STRIKE_LARGE"] call arjay_spawn;

// Spawn a large missile that strikes target position from the air
[spawnTarget1,"MISSILE_STRIKE_LARGE"] call arjay_spawn;

// Spawn a small missile that strikes target position from the air
[spawnTarget1,"MISSILE_STRIKE_SMALL"] call arjay_spawn;

// Spawn a large bomb that falls on target position from the air
[spawnTarget1,"BOMB_LARGE"] call arjay_spawn;

// Spawn a small bomb that falls on target position from the air
[spawnTarget1,"BOMB_SMALL"] call arjay_spawn;

// Spawn a large explosion on target position instantly
[spawnTarget1,"EXPLOSION_LARGE"] call arjay_spawn;

// Spawn a small explosion on target position instantly
[spawnTarget1,"EXPLOSION_SMALL"] call arjay_spawn;

// Spawn a small number of small explosions around the target
[spawnTarget1,"EXPLOSION_SMALL"] call arjay_randomLocationSpawn;

// Spawn 10 small missiles at a distance of 30 around target use random timing to spawn at random 10 second intervals
[spawnTarget1,"MISSILE_STRIKE_SMALL",10,30,true,10] call arjay_randomLocationSpawn;

// Spawn 10 large explosions at a distance of 30 around target use random timing to spawn at random 20 second intervals
[spawnTarget1,"EXPLOSION_LARGE",10,30,true,20] call arjay_randomLocationSpawn;


==========================================
arjay_camera.sqf
==========================================

/*
Add a camera to the object camera1's position, hide the camera1 object, set the camera angle at eye level
Start the cinematic with cinema borders
Film a static shot of cameraTarget1 object for 3 seconds
Stop the cinematic
Remove the camera
*/
myCamera1 = [camera1,true,"EYE"] call arjay_addCamera;  
_nil = [] spawn {    
	[myCamera1,true] call arjay_startCinematic;
	[myCamera1,cameraTarget1,3] call arjay_staticShot;
	sleep 3;    
	[myCamera1] call arjay_stopCinematic;
	[myCamera] call arjay_removeCamera;
};

/*
Add a camera to the object camera1's position, hide the camera1 object, set the camera angle at eye level
Start the cinematic with cinema borders
Film a static shot of cameraTarget1 object for 3 seconds
Stop the cinematic
Remove the camera
*/
myCamera1 = [camera1,true,"EYE"] call arjay_addCamera;  
_nil = [] spawn {    
	[myCamera1,true] call arjay_startCinematic;
	[myCamera1,cameraTarget1,3] call arjay_staticShot;
	sleep 3;    
	[myCamera1] call arjay_stopCinematic;
	[myCamera] call arjay_removeCamera;
};

/*
Add a camera to the object camera2's position, hide the camera2 object, set the camera angle at low level
Start the cinematic with cinema borders
Film a panning shot from panTarget1 to panTarget2 objects for 3 seconds hiding the pan target objects
Stop the cinematic
Remove the camera
*/
myCamera2 = [camera2,true,"LOW"] call arjay_addCamera;  
_nil = [] spawn {  
	[myCamera2,true] call arjay_startCinematic;  
	[myCamera2,panTarget1,panTarget2,3,true] call arjay_panShot;  
	sleep 3;  
	[myCamera2] call arjay_stopCinematic;
	[myCamera] call arjay_removeCamera;  
};

/*
Add a camera to the object camera3's position, hide the camera3 object, set the camera angle at birds eye view level
Start the cinematic with cinema borders
Film a static shot of cameraTarget3 object for 4 seconds
Lower the camera by 18.6 meters, taking 4 seconds to perform the movement
Stop the cinematic
Remove the camera
*/
myCamera3 = [camera3,true,"BIRDS_EYE"] call arjay_addCamera;
_nil = [] spawn {  
	[myCamera3,true] call arjay_startCinematic;  
	[myCamera3,cameraTarget3,4] call arjay_staticShot;  
	[myCamera3,18.6,4] call arjay_lowerCamera;  
	sleep 4; 
	[myCamera3] call arjay_stopCinematic;
	[myCamera] call arjay_removeCamera;
};

/*
Add a camera to the object camera4's position, hide the camera4 object, set the camera angle at low level
Start the cinematic with cinema borders
Film a static shot of cameraTarget4 object for 3 seconds
Move the camera to moveTarget1's position with an angle at high level, taking 2 seconds to perform the movement
Stop the cinematic
Remove the camera
*/
myCamera4 = [camera4,true,"LOW"] call arjay_addCamera;
_nil = [] spawn {
	[myCamera4,true] call arjay_startCinematic;  
	[myCamera4,cameraTarget4,3] call arjay_staticShot;  
	sleep 1;  
	[myCamera4,moveTarget1,"HIGH",2,true] call arjay_moveCamera;  
	sleep 2;  
	[myCamera4] call arjay_stopCinematic;
	[myCamera] call arjay_removeCamera;  
};

/*
Add a camera to the object camera4's position, hide the camera4 object, set the camera angle at low level
Start the cinematic with cinema borders
Film a static shot of cameraTarget4 object for 3 seconds
Move the camera to moveTarget1's position with an angle at high level, taking 2 seconds to perform the movement
Stop the cinematic
Remove the camera
*/
myCamera4 = [camera4,true,"LOW"] call arjay_addCamera;
_nil = [] spawn {
	[myCamera4,true] call arjay_startCinematic;  
	[myCamera4,cameraTarget4,3] call arjay_staticShot;  
	sleep 1;  
	[myCamera4,moveTarget1,"HIGH",2,true] call arjay_moveCamera;  
	sleep 2;  
	[myCamera4] call arjay_stopCinematic;
	[myCamera] call arjay_removeCamera;  
};

/*
Add a camera to the object camera5's position, hide the camera5 object, set the camera angle at eye level
Start the cinematic with cinema borders
Film a fly in shot of cameraTarget4 object for 3 seconds, not hiding the target object
Stop the cinematic
Remove the camera
*/
myCamera5 = [camera5,true,"EYE"] call arjay_addCamera;  
_nil = [] spawn {
	[myCamera5,true] call arjay_startCinematic;
	[myCamera5,cameraTarget4,false,3] call arjay_flyInShot;
	sleep 3;  
	[myCamera5] call arjay_stopCinematic;
	[myCamera5] call arjay_removeCamera;  
};

/*
Add a camera to the object camera6's position, hide the camera6 object, set the camera angle at eye level
Start the cinematic with cinema borders
Film a zoom in shot of cameraTarget4 object for 3 seconds, not hiding the target object
Stop the cinematic
Remove the camera
*/
myCamera6 = [camera6,true,"EYE"] call arjay_addCamera;
_nil = [] spawn {
	[myCamera6,true] call arjay_startCinematic;  
	[myCamera6,cameraTarget4,false,3] call arjay_zoomShot;  
	sleep 3;  
	[myCamera6] call arjay_stopCinematic ;
	[myCamera6] call arjay_removeCamera;  
};

/*
Add a live feed camera for the player at the object camera8's position, hide the camera8 object, set the camera angle at eye level
Film a zoom in shot of cameraTarget5 object for 3 seconds, not hiding the target object
Remove the live feed camera
*/
myCamera8 = [player,camera8,cameraTarget5,true,"EYE"] call arjay_createLiveFeedCamera;
_nil = [] spawn {    
	[myCamera8,cameraTarget5,false,3] call arjay_zoomShot;    
	sleep 3;    
	[] call arjay_removeLiveFeedCamera;  
};

/*
Add a live feed camera for the player at the object camera9's position, hide the camera9 object, set the camera angle at eye level
Film a static of cameraTarget5 object for 3 seconds
Switch feed effect to thermal imaging
Move the camera to moveTarget2's position with an angle at high level, taking 2 seconds to perform the movement
Remove the live feed camera
*/
myCamera9 = [player,camera9,cameraTarget5,true,"EYE"] call arjay_createLiveFeedCamera;
_nil = [] spawn {
	[myCamera9,cameraTarget5,3] call arjay_staticShot;
	sleep 1;
	["THERMAL"] call arjay_createLiveFeedEffect;
	[myCamera9,moveTarget2,"HIGH",2,true] call arjay_moveCamera;
	sleep 3;  
	[] call arjay_removeLiveFeedCamera;  
};

/*
Add a live feed camera for the player at the object camera10's position, hide the camera10 object, set the camera angle at eye level
Film a static of the player for 3 seconds
Switch feed effect to thermal imaging
Remove the live feed camera
*/
myCamera10 = [player,camera10,player, true,"EYE"] call arjay_createLiveFeedCamera;
_nil = [] spawn {
	[myCamera10,player,3] call arjay_staticShot;
	sleep 3;
	[] call arjay_removeLiveFeedCamera;  
};  

/*
Switch to an objects first person perspective, disabling the players movement
View for 10 seconds
Revert camera to original object
*/
_nil = [] spawn {
	[chaseTarget1,"FIRST_PERSON",true] call arjay_switchCamera;
	sleep 10;  
	[true] call arjay_revertCamera;  
};

/*
Add a camera to the object camera12's position, hide the camera12 object, set the camera angle at eye level
Start the cinematic with cinema borders
Film a chase shot of chaseTarget1 object for 5 seconds, not hiding the target object
Stop the cinematic
Remove the camera
*/
myCamera12 = [camera12,true,"EYE"] call arjay_addCamera;  
_nil = [] spawn {    
	[myCamera12,true] call arjay_startCinematic;
	[myCamera12,chaseTarget1,false,5] call arjay_chaseShot;  
	sleep 5;  
	[myCamera12] call arjay_stopCinematic;  
	[myCamera12] call arjay_removeCamera;  
};

/*
Add a camera to the object camera13's position, hide the camera13 object, set the camera angle at eye level
Start the cinematic with cinema borders
Film a side chase shot of chaseTarget1 object for 5 seconds, not hiding the target object
Stop the cinematic
Remove the camera
*/
myCamera13 = [camera13,true,"EYE"] call arjay_addCamera;  
_nil = [] spawn {
	[myCamera13,true] call arjay_startCinematic;  
	[myCamera13,chaseTarget1,false,5] call arjay_chaseSideShot;  
	sleep 3;  
	[myCamera13] call arjay_stopCinematic    
};

/*
Add a camera to the object camera14's position, hide the camera14 object, set the camera angle at eye level
Start the cinematic with cinema borders
Film a angled chase shot of chaseTarget1 object for 5 seconds, not hiding the target object
Stop the cinematic
Remove the camera
*/
myCamera14 = [camera14,true,"EYE"] call arjay_addCamera;    
_nil = [] spawn {
	[myCamera14,true] call arjay_startCinematic;  
	[myCamera14,chaseTarget1,false,5] call arjay_chaseAngleShot;    
	sleep 3;    
	[myCamera14] call arjay_stopCinematic    
};

/*
Add a camera to the object camera14's position, hide the camera14 object, set the camera angle at eye level
Start the cinematic with cinema borders
Film a front wheel position chase shot of chaseTarget1 object for 5 seconds, not hiding the target object
Stop the cinematic
Remove the camera
*/
myCamera15 = [camera15,true,"EYE"] call arjay_addCamera;    
_nil = [] spawn {    
	[myCamera15,true] call arjay_startCinematic;    
	[myCamera15,chaseTarget1,false,5] call arjay_chaseWheelShot;    
	sleep 3;    
	[myCamera15] call arjay_stopCinematic    
};

/*
Add a live feed camera for the player at the object camera16's position, hide the camera16 object, set the camera angle at eye level
Film a angled chase shot of chaseTarget1 object for 5 seconds, not hiding the target object
Remove the live feed camera
*/
myCamera16 = [player,camera16,chaseTarget1,true,"EYE"] call arjay_createLiveFeedCamera;  
_nil = [] spawn {      
	[myCamera16,chaseTarget1,false,10] call arjay_chaseAngleShot;  
	sleep 10;      
	[] call arjay_removeLiveFeedCamera;  
};