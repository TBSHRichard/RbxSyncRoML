# RbxSyncRoML
Adds [RoML and RoSS](https://github.com/TBSHRichard/ROBLOX-Markup-Language) support to
[RbxSync](https://github.com/evaera/RbxSync).

## Installing the Languages

Before RbxSync can recognize RoSS and RoML, you must first install the languages. To install custom languages on
RbxSync, you must have version 1.4.0 of RbxSync or higher.

Once you have a version of RbxSync that supports custom languages, open the settings page in RbxSync. There will be a
setting for the location of the `Custom Language Folder`. You can change this location to anywhere you wish. When you
have selected a folder to store custom languages in, open up that folder.

Download the [latest release](https://github.com/TBSHRichard/RbxSyncRoML/releases) (or any version of that you wish to
use) of the language plugin and place the `RoML` and `RoSS` folders inside of your custom languages folder. Then, back
on the settings page of RbxSync, click the `Reload Custom Languages` button or simply close and re-open RbxSync. That's
all the setup that's needed!

If there is no release for your OS, see the building the code section below.

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

## Build the Code

If there is no release for your OS or you want to test your development, follow these instructions for building the
code.

### 1. Setup Node Gyp

Follow the installation instructions for [node-gyp](https://github.com/nodejs/node-gyp) (you can skip installing the
node package `npm install -g node-gyp`, just follow the setup for your OS).

Also, make sure you add Python to your path. If on windows and using the node global install option, you can run
`npm --add-python-to-path install -g windows-build-tools`.

### 2. Install Node Packages

From the main directory for this project, run `npm install`. If there are failures, go back and make sure you have Node
Gyp installed properly.

Next you will have to rebuild `node-lua` to work with Electron. To do this, run
`./node_modules/.bin/electron-rebuild -v <RbxSync Electron Version>`. If you have trouble with this step, you
can view the [official Electron documentation](https://github.com/electron/electron/blob/master/docs/tutorial/using-native-node-modules.md).

To get the current Electron version RbxSync is running under, download the source for
[RbxSync](https://github.com/evaera/RbxSync) and run `npm install` from the `src` folder. Then run `electron -v` and
the version will be displayed.

### 3. Build LPEG

The LPEG library will have to be built using the same Lua version that the `node-lua` addon was built with. The easiest
way to do this is to use the same Lua libraries that it used.

Firstly, download the [LPEG source code](http://www.inf.puc-rio.br/~roberto/lpeg/). Then, follow the instructions for
your OS:

#### 3a. Windows

The easiest way to build the code on Windows is with [Visual Studio](https://www.visualstudio.com/), so download and
install it (Community version will work just fine), making sure to install the C++ tools.

Create a new Win32 Project with an output type of DLL. Copy all of the LPEG header (`.h`) and C (`.c`) files to the new
project directory.

We will also copy some files that the `node-lua` Node addon used. Copy the files from the
`/node_modules/node-lua/win64luajit` directory into the Visual Studio project directory (you actually don't need them
all, but for simplicity I'll just say copy them all).

Inside of Visual Studio, right-click on the project and select Add > Existing Item... Add all of the C (`.c`) and
header (`.h`) files.

Next, Right-click the project again and select Add > New Item... In the Add Item window, navigate to Visual C++ >
Code and select Module-Definition File (.def). Name it whatever you like and click Add. The contents of this file should
be:

```
EXPORTS
	luaopen_lpeg
```

Inside of Visual Studio, there should be a drop-down next to the Local Windows Debugger button with x86 and x64. Select
the appropriate option for your OS (x86 for 32-bit and x64 for 64-bit).

Finally, right click the project and go to Properties. In the Properties window:

 * Navigate to Configuration Properties > General. Set Target Name to `lpeg`.
 * Navigate to Configuration Properties > Linker > Input. In the Additional Dependencies text box, delete everything
   and type `lua51.lib`. Also, make sure that your Module-Definition File is displayed in that text box.

That's all the setup, just run Build > Build Solution and the location it builds the DLL to will be displayed in the
Output window. Make note of that for later!

#### 3b. Mac OS

**(I think this should work, but I don't have a Mac to test it out.)**

Firstly, make sure you can run `make`. If not, install it.

Create a directory named `lua` next to your LPEG folder. Inside of this directory we will need to copy the files that
the `node-lua` Node addon used. Copy the files from `/node_modules/node-lua/maclualib` into the new `lua` directory.

Finally, run `make` inside of your LPEG folder. If everything is successful, you will have an `lpeg.so` library.

### 4. Putting the Code Together

Now to copy the files to your Custom Languages Folder! Copy the `RoML` directory from this repository into your
Custom Languages Folder (the path is defined by you inside of the RbxSync settings). Then, copy the following files to
your `RoML` directory:

 * `src/romllib.lua` from this repository.
 * The ROBLOX-Markup-Language folder from the lib folder in this repository (you only need build/romlc.lua).
 * The `node_modules` directory from this repository (you only need the `node-lua` directory, and in this you only
   need `index.js`, `build/Release/lua51.dll` (Windows), & `build/Release/nodelua.node`).
 * Create a new directory named `lpeg` and copy your `lpeg.dll`/`lpeg.so` library inside of it.

RoSS is setup exactly the same way, just using its `lang.js` instead!

Here is the minimal directory structure required:

```
<RbxSync Custom Languages Folder>
|
+-- RoML
|   |
|   +-- lpeg
|   |   |
|   |   +-- lpeg.dll / lpeg.so
|   |
|   +-- node_modules
|   |   |
|   |   +-- node-lua
|   |       |
|   |       +-- ...
|   |
|   +-- ROBLOX-Markup-Language
|   |   |
|   |   +-- build
|   |       |
|   |       +-- romlc.lua
|   |
|   +-- lang.js
|   |
|   +-- romllib.lua
|
+-- RoSS
    |
    +-- lpeg
    |   |
    |   +-- ...
    |
    +-- node_modules
    |   |
    |   +-- ...
    |
    +-- ROBLOX-Markup-Language
    |   |
    |   +-- ...
    |
    +-- lang.js
    |
    +-- romllib.lua
```
