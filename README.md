# trackChangedFiles
A simple shell script that log all files that changed in the system since a given date.

The tool is supposed to be run as root and wont work if you're not using sudo or not logged as SU.
## How to use
**./trackChangedFiles.sh -help** : displays help.

**./trackChangedFiles.sh (no args)**: track all file changes in the system since the program started

**./trackChangedFiles.sh \"m/d/y H:M:S** : will track all file changes in the system since the outputed date
