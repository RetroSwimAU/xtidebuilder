This is a nice automated way to build XTIDE Universal BIOS ROMs, including creating custom builds.

What this does:
* Creates a containerised environment with
  * Alpine Linux
  * Subversion
  * GNU Make
  * NASM
  * UPX
  * Perl
* Clones the XUB Subversion repo
* Patches the Makefiles to be nice and unixy
* Patches out trailing whitespace in `Revision.inc`, which causes build errors (see BuB's video)
* Builds the XUB binaries using the `checksum` target, producing ready-to-burn ROM images, tested in PCem.
* Builds the configurator utility, also tested in PCem.

On Linux (and macOS probably):
* Install Docker
* Make sure current user can run docker without sudo `sudo usermod -aG docker $(whoami)`. Might need a reboot.
* Clone this repository `git clone https://github.com/RetroSwimAU/xtidebuilder` then run `./runme.sh`
* Receive XUB binaries

On Windows:
* Option 1:
  * Install WSL
  * Install Docker in WSL
  * Clone this repository `git clone https://github.com/RetroSwimAU/xtidebuilder` then run `./runme.sh`
  * Receive XUB binaries
* Option 2:
  * Install Docker Desktop
  * Download this repo -- https://github.com/RetroSwimAU/xtidebuilder/archive/refs/heads/main.zip
  * Unzip it somewhere
  * Open Command Prompt or PowerShell and go to where you unzipped it. Make sure you see compose.yml in `dir`.
  * Type `docker compose up` (Or `docker-compose up` maybe, if docker is an older version)
  * Should receive XUB binaries, look in `src/trunk/XTIDE_Universal_BIOS/Build` under where you executed the docker command.
  * NB: I haven't tried this.
 
Extra features:
* Edit the `options` file under resources to affect how the build is performed
  * For more information on what these options do, see the XUB build instructions: https://www.xtideuniversalbios.org/wiki/BuildInstructions
  * The example values I provided for a custom build came from Bits Und Bolts' video on the subject: https://www.youtube.com/watch?v=ilEZB5pY0VI

Credits:
* Bits Und Bolts https://www.youtube.com/@bitsundbolts
  * For inspiring me to build this toolchain
* XTIDE Universal BIOS Team https://www.xtideuniversalbios.org/
  * For creating this truly incredible bit of software, keeping retro PCs alive, one EPROM at a time. <3
