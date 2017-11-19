# RbxSyncRoML
Adds [RoML and RoSS](https://github.com/TBSHRichard/ROBLOX-Markup-Language) support to
[RbxSync](https://github.com/evaera/RbxSync).

## Installing the Languages

Before RbxSync can recognize RoSS and RoML, you must first install the languages. To install custom languages on
RbxSync, you must have version 1.4.0 of RbxSync or higher.

Once you have a version of RbxSync that supports custom languages, open the settings page in RbxSync. There will be a
setting for the location of the `Custom Language Folder`. You can change this location to anywhere you wish. When you
have selected a folder to store custom languages in, open up that folder.

Download the latest release (or any version of that you wish to use) of the language plugin and place the `RoML` and
`RoSS` folders inside of your custom languages folder. Then, back on the settings page of RbxSync, click the `Reload
Custom Languages` button or simply close and re-open RbxSync. That's all the setup that's needed!

## Creating a RoML Script

To create a RoML script that can be edited from outside of ROBLOX Studio, you must first create a ModuleScript inside
your game. Then you can perform either of the following:

 * Add a StringValue instance to the ModuleScript with the name of `RoML`.
 * Append `.roml` to the end of your ModuleScript name.

Then, when you use RbxSync to edit the script outside of ROBLOX, RbxSync will treat the script as RoML and will
automatically transpile the file to  Lua whenever you save!

## Creating a RoSS Script

Creating RoSS scripts are similar to RoML. For your ModuleScript, instead perform one of the following:

 * Add a StringValue instance to the ModuleScript with the name of `RoSS`.
 * Append `.ross` to the end of your ModuleScript name.
