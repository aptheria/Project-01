/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR score = 0

VAR years = 0
VAR strength = 5
VAR dexterity = 5
VAR endurance = 5
VAR intelligence = 0

VAR symbols = 0
VAR symbol_unlock = 0
VAR east_alter_active = 0

VAR locked_box_open = 0
VAR red_charm = 0
VAR west_alter_active = 0
VAR far_west_alter_active = 0

-> entrance

/* Character creation */

== character_creation ==
You find your self at the Gateway of Trials. What have you been doing over the last 5 years?
Your strength is {strength}
Your dexterity is {dexterity}
Your endurance is {endurance}
Your intelligence is {intelligence}

* [Year 1] -> stat_choice
* [Year 2] -> stat_choice
* [Year 3] -> stat_choice
* [Year 4] -> stat_choice
* [Year 5] -> stat_choice
* {years == 5} [Ready to begin] -> entrance 


== stat_choice ==
This year you spend most of your time...
+ [weightlifting] -> strength_up
+ [lockpicking] -> dexterity_up
+ [doing cardio] -> endurance_up
+ [reading] -> intelligence_up

== strength_up ==
You feel yourself getting stronger
~ years = years + 1
~ strength = strength + 1
-> character_creation

== dexterity_up ==
You feel yourself getting more dexterous
~ years = years + 1
~ dexterity = dexterity + 1
-> character_creation

== intelligence_up ==
You feel yourself getting more intelligent
~ years = years + 1
~ intelligence = intelligence + 1
-> character_creation

== endurance_up  ==
You feel yourself increasing in endurance
~ years = years + 1
~ endurance = endurance + 1
-> character_creation

/* Game start */

== entrance ==
You are now in the Gateway of Trials. There is an eastern path and a western path.
+ [Take the eastern path] -> eastern_path
+ [Take the western path] -> western_path
* [Exit] -> grading

/* Eastern path */

== eastern_path ==
Inside is a dimmly lit room. You see {symbol_unlock == 0: a locked door with a strange set of magical symbols over the lock.} {symbol_unlock == 1: an unlocked door}
+ {symbol_unlock == 0} [Examine the symbols] -> symbol_door
+ {symbol_unlock == 1} [Enter the door] -> symbol_door_unlock
* {strength >= 2} [Smash the door] -> symbol_door_unlock
+ [Go back] -> entrance

== symbol_door ==
The symbols read, {symbols == 0: "אקגן"} {symbols == 1: "4839"}
+ [Go back] -> eastern_path
* {intelligence >= 2} [This seems familier] -> decode
* {symbols == 1} [Enter the code] -> symbol_door_unlock

== decode ==
You remember these symbols from your extensive study
~ symbols = 1
-> symbol_door

== symbol_door_unlock ==
~ symbol_unlock = 1
You have entered the door. A dark hallway is in front of you.
+ [Go back] -> eastern_path
+ [Follow the path] -> far_east_path

== far_east_path ==
After walking down the hallway you see an alter in front of you.
* {east_alter_active == 0} [Activate the alter] -> east_alter_activate
+ {east_alter_active == 1} [Inspect the alter] -> east_alter
+ [Go back] -> symbol_door_unlock

== east_alter_activate ==
~ east_alter_active = 1
~ score = score + 1
As you place your hand on the alter, a surge of energy flows through you and the alter lights up.
-> far_east_path

== east_alter ==
As the alter glows you gain a deeper insight into yourself.
Your strength is {strength}
Your dexterity is {dexterity}
Your endurance is {endurance}
Your intelligence is {intelligence}
Your score is {score}
+ [Go back] -> far_east_path

/* Western path */

== western_path ==
You stand at the edge of a pool of water.
+ [Jump in] -> water1
+ [Go back] -> entrance

== water1 ==
You feel around and find {locked_box_open == 0: a locked box.} {locked_box_open == 1: an unlocked box where you got a red charm}
* {dexterity >= 1} [Try to lockpick] -> locked_box
+ [Go back] -> western_path
+ {endurance >= 1} [Keep swimming] -> water2

== locked_box ==
~ red_charm = 1
~ locked_box_open = 1
The simple lock opens and reveals a red charm that you decide to take.
-> water1

== water2 ==
The light has faded and you find yourself in a large open underwater area. It would be foolish to push forward
+ [Go back] -> water1
+ {intelligence <= 2} {endurance >= 2} [Keep swimming] -> water3

== water3 ==
You see a dim light off in the distance. It would be wise to get some air.
+ [Follow the light] -> water3_room
+ {intelligence == 0} {endurance >= 3} [Keep swimming] -> water4
+ [Go back] -> water2

== water3_room ==
You swim towards the light and find a ledge to climb up on. You see a dormant alter in front of you.
* {west_alter_active == 0} [Activate the alter] -> west_alter_activate
+ {west_alter_active == 1} [Inspect the alter] -> west_alter
+ [Go back] -> water3

== west_alter_activate ==
~ west_alter_active = 1
~ score = score + 1
As you place your hand on the alter, a surge of energy flows through you and the alter lights up.
-> water3_room

== west_alter ==
As the alter glows you gain a deeper insight into yourself.
Your strength is {strength}
Your dexterity is {dexterity}
Your endurance is {endurance}
Your intelligence is {intelligence}
Your score is {score}
+ [Go back] -> water3_room


== water4 ==
{endurance <= 4: This feels like a mistake, you are about to run out of air.} {endurance >= 5: Your extensive training prepared you for this.}
+ [Go back] -> water3
+ {endurance <= 4} [Keep swimming] -> drown
+ {endurance >= 5} [Keep swimming] -> water5

== drown ==
You feel your lungs fill with water, you are about to die.
* {red_charm == 1} [Pray to the red charm] -> saved
-> END

== saved ==
You lose consiousness for a moment and wake up back at the enterance
-> entrance

== water5 ==
You made it out of the water and are back on land. You see a dormant alter in front of you.
* {far_west_alter_active == 0} [Activate the alter] -> far_west_alter_activate
+ {far_west_alter_active == 1} [Inspect the alter] -> far_west_alter
+ [Go back] -> water4

== far_west_alter_activate ==
~ far_west_alter_active = 1
~ score = score + 1
As you place your hand on the alter, a surge of energy flows through you and the alter lights up.
-> water5

== far_west_alter
As the alter glows you gain a deeper insight into yourself.
Your strength is {strength}
Your dexterity is {dexterity}
Your endurance is {endurance}
Your intelligence is {intelligence}
Your score is {score}
+ [Go back] -> water5

== grading ==
{score == 0: You have completely failed the trials} {score == 1: You have barely passed the trials} {score == 2: You have passed with a respectable grade} {score == 3: You have passed with an outstanding grade}
-> END
