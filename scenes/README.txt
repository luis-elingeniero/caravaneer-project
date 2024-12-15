# Scenes Folder

Scenes define how the player interacts with the world. Every menu, map, and interaction comes from here. 

Folder breakdown:
- **main_menu/**: The game's starting point! Contains the title screen and its buttons. Modify with caution—breaking this means nobody starts the game.
- **gameplay/**: Includes combat screens, trading UI, and all those juicy in-game mechanics. If you’re touching this, know what you’re doing (have a backup copy do that).
- **ui/**: Anything related to user interaction—inventory screens, settings menus, etc. If it pops up in front of the gameplay, it’s probably here.
- **world/**: Maps, towns, and zones. The sandbox where the player roams. Add new areas here, but follow naming conventions to avoid chaos.

Pro tip: If you're adding new scenes, test them extensively before committing. Nobody likes a crash-to-desktop surprise.