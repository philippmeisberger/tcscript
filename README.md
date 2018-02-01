TCScript
========

TCScript simplifies and automates the mounting and dismounting routine of a TrueCrypt volume. TrueCrypt is needed anyway! It is recommend that a keyfile is used for the decryption of the volume. Then this keyfile can be on a external SD card (token). The script can be used to mount a TrueCrypt volume while booting. The volume only gets mounted if the token is plugged in. On shutdown the volume gets automatically dismounted.

Linux
-----

### Installation

Add PM Code Works repository

    `~# echo "deb http://apt.pm-codeworks.de stretch main" | tee /etc/apt/sources.list.d/pm-codeworks.list`

Add PM Code Works key

    ~# wget -qO - http://apt.pm-codeworks.de/pm-codeworks.de.gpg | apt-key add -
    ~# apt-get update

Install the packages

    ~# apt-get install tcscript truecrypt zenity

### Setup

Edit the file */etc/tcscript.conf*.

* `MOUNTDEVICE`: The path to the encrypted TrueCrypt device e.g. */dev/disk/by-id/ata-MANUFACTURER_MODEL_A0B1C2D3E4F5-part2*.

* `MOUNTPATH`: The path to the directory where the TrueCrypt device should be mounted e.g. */media/Safe*. The path must exist!

* `TOKENDEVICE`: The path to the token device that contains the keyfile. It is recommended to use a removable device like an USB stick or an SD card. Device will be mounted by TCScript.

* `TOKENPATH`: The path to the directory where the token device should be mounted. The path must exist!

* `KEYFILE`: The path to the keyfile created by TrueCrypt during the device encryption setup.

* `USERNAME`: (Optional) The name of the user mounting the TrueCrypt device. Only necessary if the device shall be mounted during boot sequence.

  * To enable automatically mounting during boot sequence

        `~# update-rc.d tcscript defaults`

  * To disable this

        `~# update-rc.d tcscript remove`

* `LOGGING`: (Optional) Set to `1` to enable logging or `0` to disable it.

* `ERRORLOG`: (Optional) File to append errors. Only used if *LOGGING* is set to `1`.

* `INFOLOG`: (Optional) File to append information. Only used if *LOGGING* is set to `1`.

* `DEBUGLOG`: (Optional) File to append debug output. Only used if *LOGGING* is set to `1` and option `--debug` is set.

As TrueCrypt needs root access rights it is not possible to mount an encrypted TrueCrypt device as non-root user per default. To make this possible the sudoers file (package *sudo* is required) must be edited using the `visudo` command. Following must be added: `USER  ALL=(ALL) NOPASSWD: /usr/bin/truecrypt` (where `USER` must be the real username).

### Commands

* To mount a TrueCrypt device

    `~$ tcscript --mount`

* To dismount a TrueCrypt device

    `~$ tcscript --dismount`

* To auto mount a TrueCrypt device

    `~$ tcscript --auto`

* To get the current status

    `~$ tcscript --status`

* Following options can also be specified
    * `--debug`: Shows debug information
    * `--interactive`: Shows graphical dialogs using Zenity
    * `--silent`: Suppress error if keyfile could not be found

Windows
-------

### Installation

1. Install TrueCrypt (version 7.1a can be found in "setup" directory)

2. (Optional) Install [Zenity](http://www.placella.com/software/zenity/#downloads)

3. Install [TCScript](http://www.pm-codeworks.de/tcscript.html)

### Setup

Edit the file *C:\Program Files\TrueCrypt\tcscript.conf.cmd*.

* `MOUNTDEVICE`: The path to the encrypted TrueCrypt device e.g. *\Device\Harddisk0\Partition2*.

* `MOUNTPATH`: The drive where the TrueCrypt device should be mounted e.g. *V:\\*. The drive must not exist yet!

* `KEYFILE`: The path to the keyfile created by TrueCrypt during the device encryption setup.

### Commands

* To mount a TrueCrypt device

    `tcscript /mount`

* To dismount a TrueCrypt device

    `tcscript /dismount`

* To auto mount a TrueCrypt device

    `tcscript /auto`

* To get the current status

    `tcscript /status`

* Following options can also be specified
    * `/debug`: Shows debug information
    * `/interactive`: Shows graphical dialogs using Zenity
    * `/silent`: Suppress error if keyfile could not be found

Questions and suggestions
-------------------------

If you have any questions to this project just ask me via email:

<team@pm-codeworks.de>
