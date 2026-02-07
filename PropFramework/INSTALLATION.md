# PropFramework - Installation Guide

## For Mod Users

### Installation from Steam Workshop (Recommended)

1. Open Steam and go to Project Zomboid's Workshop
2. Search for "PropFramework"
3. Click "Subscribe"
4. The mod will automatically download and install
5. Launch Project Zomboid
6. The mod will be enabled automatically

### Manual Installation

If you need to install manually (for testing or non-Steam versions):

1. Download PropFramework from GitHub or other source
2. Locate your Project Zomboid mods folder:
   - Windows: C:\Users\YourUsername\Zomboid\mods\
   - Linux: ~/.zomboid/mods/
   - Mac: ~/Library/Application Support/Zomboid/mods/

3. Extract the PropFramework folder into the mods directory
4. Your path should look like: [...]\Zomboid\mods\PropFramework\mod.info

5. Launch Project Zomboid
6. Go to Mods menu
7. Find "PropFramework" and enable it
8. Click Apply

### Verify Installation

1. Start the game
2. Check the console (F11 or ~) for PropFramework initialization messages
3. You should see "PropFramework v1.0.0" on startup

### Troubleshooting

Problem: Mod not showing in list
- Check the folder is named "PropFramework"
- Verify mod.info file exists in the root
- Restart the game completely

Problem: Errors on startup
- Check console for specific error messages
- Verify you have Build 42 (unstable branch)
- Try disabling other mods to check for conflicts

Problem: Mods requiring PropFramework not working
- Make sure PropFramework is enabled in mod menu
- PropFramework should be loaded before dependent mods
- Check dependent mods are compatible with current version

## For Mod Developers

### Adding PropFramework as Dependency

In your mod.info file:
```
name=My Awesome Mod
id=MyAwesomeMod
require=PropFramework
```

### Using PropFramework in Your Mod

In your Lua files:
```lua
require "PropFramework_Core"
require "PropFramework_Professions"
require "PropFramework_Skills"

if PropFramework:IsLoaded() then
    -- Your code here
else
    print("ERROR: PropFramework not found!")
end
```

### Distributing Your Mod

When uploading to Steam Workshop:
1. List PropFramework as a required item
2. Mention it in your mod description
3. Link to PropFramework Workshop page

When distributing elsewhere:
1. Include "Requires PropFramework" in description
2. Provide link to PropFramework download
3. List it in your mod's README

### Testing with PropFramework

1. Subscribe to PropFramework on Steam Workshop (or install manually)
2. Place your mod in mods folder
3. Enable both mods
4. Test thoroughly

## Updating

### Steam Workshop
Updates are automatic. Just restart the game and Steam will download the latest version.

### Manual Installation
1. Delete old PropFramework folder
2. Download new version
3. Extract to mods folder
4. Restart game

## Uninstalling

### Steam Workshop
1. Open Steam Workshop
2. Find PropFramework in your subscribed items
3. Click "Unsubscribe"
4. Restart game

Note: Mods that depend on PropFramework will stop working.

### Manual Installation
1. Delete the PropFramework folder from mods directory
2. Restart game

## Compatibility

- Project Zomboid Version: Build 42 (unstable)
- Multiplayer: Yes (all players need the mod and dependent mods)
- Saved Games: Safe to add or remove

## Support

- Steam Workshop: Post in comments or discussions
- GitHub: Open an issue
- Check documentation in README.md

## File Structure

```
PropFramework/
├── mod.info
├── README.md
├── QUICK_REFERENCE.md
└── media/lua/
    ├── shared/
    │   ├── PropFramework_Core.lua
    │   ├── PropFramework_Professions.lua
    │   ├── PropFramework_Traits.lua
    │   ├── PropFramework_Skills.lua
    │   ├── PropFramework_Items.lua
    │   ├── PropFramework_Recipes.lua
    │   ├── PropFramework_Events.lua
    │   ├── PropFramework_Utils.lua
    │   ├── PropFramework_UI.lua
    │   └── PropFramework_Loader.lua
    └── client/
        └── ExampleProfessionMod.lua
```
