# Mods Folder

Welcome, modders! This is your playground. Drop your creations here, and the game will load them in order. Each mod should be in its own folder, like this:

/mods/
    my_first_mod/
        assets/
        scenes/
        scripts/

Mods are loaded with priority based on folder order. If two mods conflict (e.g., both edit the same settlement), the firt loaded one takes priority. Make sure mods don’t overwrite base files directly—always layer changes. 

Pro tip: Document what your mod does in a `mod_info.json` file!

(infuncional dont work)