TCScript
========

tcscript simplifies the mounting and dismounting routine of a TrueCrypt volume. TrueCrypt is needed anyway! It is recommend that a  keyfile  is used  for  the  decryption of the volume. Then this keyfile can be on a external SD card (token). The script can be used to mount  a  TrueCrypt volume  while  booting.  The  volume  only gets mounted if the token is plugged in. On shutdown the volume gets automatically dismounted.

[Homepage](http://www.pm-codeworks.de/tcscript.html)


Installation
============

* Add PM Codeworks repository:
    * `~# wget http://apt.pm-codeworks.de/pm-codeworks.list -P /etc/apt/sources.d/`

* Add PM Codeworks key:
    * `~# wget -O - http://apt.pm-codeworks.de/pm-codeworks.de.gpg.key | apt-key add -`
    * `~# apt-get update`

* Install the package + TrueCrypt:
    * `~# apt-get install tcscript truecrypt`

* Edit the file /etc/tcscript.conf
