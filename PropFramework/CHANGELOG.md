# Changelog

# Version 1.0.0 - Initial Release

# Core Framework
-  Core initialization system with module tracking
-  Debug mode for verbose logging
-  Version tracking and compatibility checks

# Modules

# Professions Module
- Register custom professions with skills, traits, and starting items
- Apply professions to players dynamically
- Manage profession-specific XP bonuses
- Support for recipes and custom icons

# Traits Module
- Register custom traits with costs and effects
- Mutually exclusive trait system
- Trait requirements checking
- Add/remove traits from players dynamically
- Effect callbacks (onAdd, onRemove)

# Skills Module
- Give XP to any skill
- Set skill levels directly
- Custom XP multipliers per skill
- Level-up callback system
- Skill requirement checking
- Get all player skills at once

# Items Module
- Give/remove items from players
- Check item possession and count
- Spawn items at world locations
- Custom item properties via modData
- Item transfer between players
- Item type checking (food, weapon, etc.)
- Condition management

# Recipes Module
- Register custom crafting recipes
- Skill and ingredient requirements
- Recipe knowledge management
- Check if player can craft
- Category organization
- Integration with game's recipe system

# Events Module
- Custom event system with priorities
- Hook into game events easily
- Convenience wrappers (OnPlayerCreate, OnLevelUp, etc.)
- Custom framework events
- Scheduled and repeating events
- Error handling for callbacks

# Utils Module
- Table utilities (deep copy, merge, contains, size)
- String utilities (split, trim, starts/ends with)
- Math utilities (clamp, lerp, round, random)
- Player utilities (position, distance, nearby players)
- Time utilities (game time, day/night check)
- World utilities (valid location, indoors check)
- Validation helpers
- Serialization utilities
- Color utilities

# UI Module
- Notification system with queuing
- Tooltips and context menus
- Debug windows for development
- On-screen text display
- Progress bars
- Confirmation and input dialogs
- Health bar displays
- Color utilities and health-based coloring

# Documentation
- Comprehensive README with full API reference
- Quick reference guide for common tasks
- Complete example mod demonstrating usage
- Inline code comments throughout

# Example Mod
- Three complete profession examples (Survivalist, Auto Mechanic, Combat Medic)
- Event handler demonstrations
- Level-up reward system example
- Console command integration

# Compatibility
- Build 42 (unstable) compatible
- Multiplayer support
- Safe to add/remove from existing saves

# Known Limitations
- Some UI features require additional implementation for full visual integration
- Timed events (Schedule/Repeat) need game's event system integration
- Some advanced recipe features may need PZ 42 API updates

# Future Plans
- Integration with Build 42's new profession system
- Enhanced UI rendering with custom panels
- More built-in profession templates
- Skill tree visualization
- Quest/mission system
- Achievement system
- Data persistence improvements
- Localization support
