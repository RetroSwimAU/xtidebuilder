This is a nice automated way to build XTIDE Universal BIOS ROMs, including creating custom builds. The latter being the real benefit here.

What this does:
* Creates a containerised environment with
  * Debian Linux Bookworm
  * Bash
  * Subversion
  * GNU Make
  * NASM
  * UPX
  * Perl
* Clones the XUB Subversion repo
* Patches the Makefiles to be nice and unixy
* Patches out trailing whitespace in `Revision.inc`, which causes build errors (see BuB's video)
* Builds the XUB binaries using the `checksum` target, producing ready-to-burn ROM images, tested in QEMU.
* Builds the configurator utility, tested in QEMU.
* Using a Github Action, verifies weekly that the toolchain produces working results in Linux, and macOS x86+ARM.

Last manual validation:

Linux [![Weekly Build Validation](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build.yml/badge.svg?branch=main&event=workflow_dispatch)](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build.yml)

macOS [![Weekly Build Validation](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build-macos.yml/badge.svg?branch=main&event=workflow_dispatch)](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build-macos.yml)

macOS ARM [![Weekly Build Validation](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build-macos-arm.yml/badge.svg?branch=main&event=workflow_dispatch)](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build-macos-arm.yml)

Last scheduled validation:

Linux [![Weekly Build Validation](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build.yml/badge.svg?branch=main&event=schedule)](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build.yml)

macOS [![Weekly Build Validation](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build-macos.yml/badge.svg?branch=main&event=schedule)](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build-macos.yml)

macOS ARM [![Weekly Build Validation](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build-macos-arm.yml/badge.svg?branch=main&event=schedule)](https://github.com/RetroSwimAU/xtidebuilder/actions/workflows/validation-build-macos-arm.yml)


On Linux and macOS:
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
  * Open Command Prompt or PowerShell and go to where you unzipped it. Make sure you see compose.yaml in `dir`.
  * Type `docker compose up` (Or `docker-compose up` maybe, if docker is an older version)
  * Should receive XUB binaries, look in `src/trunk/XTIDE_Universal_BIOS/Build` under where you executed the docker command.
  * ~~NB: I haven't tried this.~~ Tried it now, and it works great! :D
 
Extra features:
* Edit the `options` file under resources to affect how the build is performed
  * `BUILD` is the make target. E.g. `all`, `small`, `large`, `custom`, `checksum`, etc. Default is `checksum`, as this produces ready-to-flash ROMs.
  * `CUSTOM_DEFINES` is the list of modules to include in a custom build. E.g. `MODULE_STRINGS_COMPRESSED`,  `MODULE_HOTKEYS`,  `MODULE_8BIT_IDE`, etc.
  * `CUSTOM_SIZE` is the output ROM size for a custom build. E.g. `12288`.
  * For a list of make targets and modules, see the Makefile contents: https://www.xtideuniversalbios.org/svn/xtideuniversalbios/trunk/XTIDE_Universal_BIOS/makefile
  * For more information, see the XUB build instructions: https://www.xtideuniversalbios.org/wiki/BuildInstructions
  * The example values I provided for a custom build came from Bits Und Bolts' video on the subject: https://www.youtube.com/watch?v=ilEZB5pY0VI
* If you don't like Docker and wish to build directly in your Linux environment, got you covered.
  * Requires Make, NASM, UPX, Subversion, and Perl.
    * E.g. `sudo apt install make nasm upx-ucl subversion perl`
  * Clone the repo and run `./uncontained.sh`
    * Scripts use GNU `sed` syntax, so on macOS, get `gnu-sed` from Homebrew `brew install gnu-sed`.
    * Then something like `PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH" ./uncontained.sh` should allow the script work.
 
Validation:
* On a weekly schedule, GitHub builds the `checksum` target, and boots the `ide_386.bin` artifact in QEMU with a pre-built HDD image.
* A screenshot is saved from QEMU and provided on the action summary to ensure the toolchain is producing viable binaries.
* The ARM validation currently does not use Docker, but rather tha `uncontained.sh`. This is a GitHub hosted runner limitation, may be fixed in the future.

Credits:
* Bits Und Bolts https://www.youtube.com/@bitsundbolts
  * For inspiring me to build this toolchain
* XTIDE Universal BIOS Team https://www.xtideuniversalbios.org/
  * For creating this truly incredible bit of software, keeping retro PCs alive, one EPROM at a time. <3
