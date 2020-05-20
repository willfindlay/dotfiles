                        _________ _        _        _  _______
               |\     /|\__   __/( \      ( \      ( )(  ____ \
               | )   ( |   ) (   | (      | (      |/ | (    \/
               | | _ | |   | |   | |      | |         | (_____
               | |( )| |   | |   | |      | |         (_____  )
               | || || |   | |   | |      | |               ) |
               | () () |___) (___| (____/\| (____/\   /\____) |
               (_______)\_______/(_______/(_______/   \_______)

    ______   _______ _________ _______ _________ _        _______  _______
   (  __  \ (  ___  )\__   __/(  ____ \\__   __/( \      (  ____ \(  ____ \
   | (  \  )| (   ) |   ) (   | (    \/   ) (   | (      | (    \/| (    \/
   | |   ) || |   | |   | |   | (__       | |   | |      | (__    | (_____
   | |   | || |   | |   | |   |  __)      | |   | |      |  __)   (_____  )
   | |   ) || |   | |   | |   | (         | |   | |      | (            ) |
   | (__/  )| (___) |   | |   | )      ___) (___| (____/\| (____/\/\____) |
   (______/ (_______)   )_(   |/       \_______/(_______/(_______/\_______)

               Author:           William Findlay
               Email:            william@williamfindlay.com
               Last Modified:    05/20/20
               License:          GPLv3

These are the dotfiles I use on my ArchLinux install.

While parts of this repo may be useful to you, it is likely far more
productive to selectively edit these files or take snippets from them
as you see fit. These dotfiles are designed with my personal use in mind;
in particular many settings such as email, username, etc. are set to MY
email address, name, etc.

These dotfiles come with no warranty.

A Word of Caution
=================

The targets in the Makefile use the rsync command to overwrite existing
file and directories. I have set up a special backups directory in this
project where rsync will copy existing files before overwriting them;
however, you should still exercise caution before running make install.

Acknowledgements
================

These dotfiles are partially based on Jon Gjengset's config files.
You can find them here: https://github.com/jonhoo/configs
