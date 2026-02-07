# PropFramework - Overview

Version: 1.0.0
For: Project Zomboid Build 42 (unstable)
Purpose: Core framework for profession and trait mod development
Distribution: Steam Workshop (primary), GitHub (secondary)

## What is PropFramework?

PropFramework is a comprehensive modding framework that provides reusable functions and systems for creating custom professions, traits, skills, items, recipes, and more in Project Zomboid Build 42.

## Why PropFramework?

Instead of every mod developer writing the same basic functions, PropFramework provides a tested, standardized API. This means:

- Faster mod development
- Better compatibility between mods
- Fewer bugs and errors
- Consistent behavior across mods
- Easy updates and maintenance

## Installation

Primary: Steam Workshop
1. Search "PropFramework" in PZ Workshop
2. Click Subscribe
3. Done

Alternative: Manual installation for non-Steam versions
See INSTALLATION.md for details

## For Mod Users

PropFramework is a dependency mod. You install it once, and it powers multiple profession and trait mods.

When you see "Requires PropFramework" on a mod:
1. Subscribe to PropFramework on Steam Workshop
2. Subscribe to the mod you want
3. Both will work together automatically

PropFramework itself adds no content to the game - it's purely a tool for other mods.

## For Mod Developers

PropFramework provides 8 core modules:

1. Professions - Create and manage custom professions
2. Traits - Build custom traits with requirements
3. Skills - Handle skill XP and leveling
4. Items - Manage items and inventory
5. Recipes - Define crafting recipes
6. Events - Hook into game events
7. Utils - 50+ helper functions
8. UI - Interface utilities

Quick Example:
```lua
require "PropFramework_Professions"

PropFramework.Professions:Register({
    name = "Mechanic",
    cost = 6,
    xp = {Mechanics = 4, Metalworking = 2},
    traits = {"Handy"}
})

PropFramework.Professions:AddStartingItem("Mechanic", "Base.Wrench", 1)
```

That's it. Your profession is ready.

## Steam Workshop Integration

When uploading your mod to Steam Workshop:
1. Add PropFramework as a required item
2. Mention it in your description
3. Link to PropFramework workshop page
4. Your mod will automatically check for PropFramework

Steam handles dependencies automatically, so users just click subscribe and everything works.

## Core Features

Profession System:
- Starting skills with XP bonuses
- Trait combinations
- Starting items and equipment
- Recipe knowledge

Trait System:
- Point costs (positive/negative)
- Mutual exclusivity rules
- Skill requirements
- Custom effect callbacks

Skill Management:
- XP granting and multipliers
- Level-up detection
- Requirement checking
- Bulk operations

Item System:
- Spawning and inventory management
- Custom properties
- Item transfers
- Type checking

Recipe System:
- Skill requirements
- Ingredient lists
- Crafting times
- Recipe knowledge

Event System:
- Custom events
- Priority callbacks
- Game event hooks
- Scheduled events

Utilities:
- Table operations
- String manipulation
- Math calculations
- Player/world queries
- Time management

UI System:
- Notifications
- Progress bars
- Dialogs
- On-screen text

## Documentation

README.md - Complete API reference
QUICK_REFERENCE.md - Fast lookup guide
INSTALLATION.md - Setup instructions
CHANGELOG.md - Version history

## Example Included

ExampleProfessionMod.lua shows three complete professions:
- Survivalist (outdoor specialist)
- Auto Mechanic (vehicle expert)
- Combat Medic (military medical)

Study this file to learn the framework.

## Using PropModCreator

PropModCreator is a separate Python GUI tool that generates mods using PropFramework.

Non-programmers can:
1. Open PropModCreator
2. Fill in forms
3. Generate working mods
4. Upload to Steam Workshop

PropModCreator mods automatically use PropFramework and list it as a dependency.

## Multiplayer Compatibility

PropFramework works in multiplayer. Requirements:
- Server must have PropFramework installed
- All players must have PropFramework
- All players must have dependent mods

Steam Workshop handles this automatically for players.

## Version Compatibility

Current version: 1.0.0
Build 42 only (unstable branch)

Mods should specify PropFramework version in their documentation.

## Support

Steam Workshop: Use comments and discussions
GitHub: Open issues for bugs or features
Documentation: Check README and QUICK_REFERENCE

## Technical Details

Language: Lua
Lines of Code: ~1600
Modules: 10
Functions: 200+
File Size: 76KB

No external dependencies - pure Lua using PZ's built-in systems.

## Performance

PropFramework is lightweight and efficient:
- Loads on game start
- Minimal memory footprint
- No performance impact during gameplay
- Efficient function calls

## Mod Compatibility

PropFramework is designed to be compatible with other mods. It:
- Doesn't modify base game files
- Uses proper namespacing (PropFramework.*)
- Respects other mods' space
- Follows PZ modding best practices

## Development Workflow

For mod developers:
1. Subscribe to PropFramework on Steam Workshop
2. Create your mod files
3. Add require=PropFramework to mod.info
4. Use PropFramework functions
5. Test locally
6. Upload to Steam Workshop with PropFramework as dependency

For users:
1. Subscribe to PropFramework
2. Subscribe to mods that use it
3. Play

## Common Use Cases

Character Creation:
- Custom professions
- Background traits
- Starting scenarios

Gameplay Enhancement:
- Skill progression systems
- Custom recipes
- Item management

Server Customization:
- Role-play professions
- Custom starting loadouts
- Balanced profession packs

## Future Development

PropFramework follows semantic versioning:
- 1.0.x - Bug fixes and minor improvements
- 1.x.0 - New features, backward compatible
- 2.0.0 - Major changes, may break compatibility

Updates distributed through Steam Workshop automatically.

## Contributing

PropFramework is open source on GitHub.

Report bugs through:
- Steam Workshop discussions
- GitHub issues

Suggest features through:
- GitHub discussions
- Steam Workshop

## License

MIT License - Free to use in any mods

## Credits

Created for the Project Zomboid modding community
Designed for ease of use and broad compatibility
Built on Project Zomboid's modding API

## Quick Stats

10 Lua modules
200+ functions
8 major systems
~1600 lines of code
76KB total size
Build 42 compatible
Multiplayer ready
Steam Workshop integrated
MIT licensed
Community supported
