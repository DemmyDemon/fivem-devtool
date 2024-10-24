# fivem-devtool
The barebones stripped-down version of my personal development tool

## Usage

To activate the devtool, issue the `devtool` command. The same command again deactivates.

If run from the server console, this will not work, and will generate an error message.  It takes no arguments.

This will display the text `F5: `, followed by the currently configured commands, at the top of the client screen.

To execute the configured command, press [control action](https://docs.fivem.net/docs/game-references/controls/) 166, INPUT_SELECT_CHARACTER_MICHAEL, which is bound to F5 by default.

To change what command is used, hold [control action](https://docs.fivem.net/docs/game-references/controls/) 21, INPUT_SPRINT, while pressing control 166.  This is bound to Shift by default, making the default combination Shift+F5

If you want to issue more than one command, separate them with a semicolon, `;`.

A short delay will be given between each command. If you want a longer delay, add more semicolons.

The commands are executed *exactly as you give them*, and they are run *on the client*, meaning your client still needs the required permissions to execute the command.

## Okay, how do I see the fancy stuff?

Sorry, there is no fancy stuff. it was all stripped out.  This is just an example script for you to build your own devtools on.
