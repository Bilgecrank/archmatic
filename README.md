# Arch Linux Post Installation Setup and Config Scripts

```ascii
,:cccccccccllooddxxkOOOOOOO00KKKKKKKKKKK0KKXXKKKKKKKK00OOOOOO00KKKKKKKKKKKKK0OkkxxkOOOOOkkkkkxdodxxxxddddddddddddddddddocccc:::::::::
ccccccllllloddxkkkkO0000000KKKKKKKKKKKK0000KKKKKKK0KK0OOOOOOO00KKKKKKKKXXKKK000OkkkO0OOOOOkkxollcllc:,'''',,,,;;:lllloolcccc:::::::::
cccccloooddxxkkkOOO000K000KKKKKKKKKKK0OxoolllloooodkkkkkkkkkO00KKKKKKKXXXKK0000Okxxk0OOkOkkxdol:;'.....  .....'';::::cllcc:;:::::::::
cllooooddxkkkOOO000KKKK00KK0Okxddolc;,,'.........',;,;;coxxkO000KKKKKKKXXXK000OkxdoxOOkkOkkxdocc:......  .....;cll:'.;oolc:,;c:::::::
llodddxxkkkkO0000000Okxdoolc;,,,''.....,,..',;,..'''':clloxkO000KKKKKKKXXXK000Oxdl:lkOkkOOkxdolll:,.........'cllll,..;odolc;,,;::::::
oodxxkOOOOOOOOkxdc,,'''',:cclooool;'',,''...........;lolloxkO00KKKXKKKXXXXKK00kxl;:okOOOOOkxxoccloolc::::clloooool,..:odool:;'.',;:::
dxxkOOOOOkoc:;;,,;;:clloodxxxkkkxdl,..........'''..,odlcloxkOO0KKKXXKXXXXXKK00Odolodk00OOOOkxdc,:odxxxxxxkkxdddooc. .coooolc:,''.';::
kkkOOOOOOx:',:lodxxkkkkkkkOkOOOOOkxo;....''''....':dddlcldkkO000KKKXXXXXXXKKK0OxoolcdO0OOOOkkxl::ldxxxkkkkxxxxdddc..,lllooolc;'...'::
OOOO000OOOd::dxxkkkOOOOO000000000Okkdl;........,:oxxxdo:cxOOO0KKKKKXXXXKXKKKKK0Oxo::dO0OOOOkkxdc,;odxxkkkkxxxxddd:.,clllooolc:,...;::
000O00OOOko,;dkkkOOOOO000KKKKKKKK0OOkxdolc::cldxxkkkkd:;cxOOO00KKKKXXXXXKKKKKKK0xollxkO0OOOkkxxo:;:coxxxxkxxxdddc,':llllooll:;,'';:::
KKK000OOOOx:;oxkOOOOO000KKKKKKKKKK00OOOOkkkkkOOOkkkkxl',okOOOO00KKKXXXXXXKKKKKK0kdlodxO0OOOOkkkxdol:coddddxdddoc,,:lolloolll:;'..';::
XXXK00OOkkxl:cdkkO00000KKKXXXXXKKKK0000000OOOOOOkkkxl,'cxOOkOO0K0KKXXXKXXKKKKK0OkxolcldkkOOOkxkxxddlc:clollooc;,;:loolooollc;'.,;;;;:
KKKKK00OOkxo;,oxkO00KKKKKXXXXXXXKKKKKKKKKK0000OOOkxl,,cxxkkkO0KKK0KXXKKKKKKXK00Oxddl:,;cdkkkxxxxxdoolc:c:cc:::;:llllooool:,,'';c:..';
KKKKK00OOOkd;.,okO00KKXXKKKKXXXXKKKKKKKKK0000OOOkxl,,cdxxkkO00KXKKKKKKKKKKKKK00kdoolc:'.;ldxxddddddoooolcclllllloolloooc,...,:::,..';
XXKKKK0OO0Odl,.,oO00KKXKKKKKKXXKKKKKKKKKK0000OOkxl;;ldxxxkO0KKKXXXXKKKKKKKKK000kxolc::;...cdxxxddxdddoooolloolllllllc;,...,;;;;'..';:
XXXXKK00OOOkxoc;:oxO00KKKKKKKKKKK00KKXKKK0000OOd;':dxxxxxk0KKXXXXXKKKKKKKXXK00Oxdl::c:;,..'lddxxddddddddoooooolllc;'...',;;;,,...':::
XXXXKKKK00OOOkkdocldkOO0KKKKKKK0000KKKK00000Oxl:coxxxxkkO00KKXXXXKKKKKKKXXK00Okdl;,;coc;'..;looooodddddddooollc;'...,;:;;;;;'';,';c::
XXXXXXXKKKKKKK00kxdoodkkOOOOO000000000000Okxc;cokkxxkkOO00KKKKKXXKKKKXXXKKXK0xdo:'..;ll;'...;ccccllooooollc;,'...';:::;;;,,,,;:,.,c::
XXXXXXNXXXXXXXKKK0Oxl:::coxkOOOOO0OOkkkkxl::coxkkkxxk000KKKKKKKKKKKXXXXXKKX0kollc,. .:c;,'...;:::::cc:::;'....,;:::;,,'..',:cc:..,c::
XXXXNXXXXXXXXXXXKKK0Oxoc,,,:lolloddddddolloddxxkxkkO00000KKKKKKKKKKXXXXKKK0kdl::;,. .;;,'....;cccc::,'.....,:::;;;,'....';:ccc;..,c::
XXXXXXXXXXXXXKKXXKK0000OkdollcccldddxxxxxkkkxxkkOO0000000KKKKXXKKKXXXKK000kdlc:;'.  .,,''....;c::,....',;:cc::;'.....',,;::ccc;. ':::
xkOO0K00KKKKKKKKKKK00000000OOOOOOOkkOOOOOOkkkkOOOO00OO0O00KKKXXKKXXK00OOkxddolcc;.  .'''...........,;:c::::,'.....';;:::::cccc;. .:::
```

This README contains the steps I do to install and configure a fully-functional Arch Linux installation containing a desktop environment, all the support packages (network, bluetooth, audio, printers, etc.), along with all my preferred applications and utilities. The shell scripts in this repo allow the entire process to be automated.

## Pre-installation

Follow the steps from the [Arch installation guide](https://wiki.archlinux.org/title/Installation_guide).

These are the ratios

| Partition | Size |
| -- | -- |
| /efi | 4GB |
| / | 100GB (under LVM) |
| /swap | 10GB (under LVM) |
| /home | Remainder (under LVM) |

## Installation

Follow these steps to get up to speed.

### Install Reflector.
Reflector allows the fastest Arch mirrors to be used.

```shell
sudo pacman -Syu
sudo pacman -S reflector rsync curl
```

Now generate mirrorlist.


```shell
sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
```

Set the `reflector.timer` to ensure that this is updated regularly. Check `/etc/xdg/reflector/reflector.conf` for settings, and make sure they match the above.

```shell
systemctl enable reflector.timer --now
```

### Initialize .gitconfig file
So we can clone this repo...

```shell
git config --global user.name "your-username"
git config --global user.email "your-email@gmail.com"
```

### Clone ArchMatic

Typically I just clone it into the home folder and delete it once I'm done.

```shell
git clone https://github.com/Bilgecrank/archmatic.git
```

### Run ArchMatic files
Run the following scripts:

    $   ./1-xorg.sh
    $   ./2-xfce.sh 
    $   ./3-network.sh 
    $   ./4-bluetooth.sh 
    $   ./5-audio.sh 
    $   ./6-printers.sh 
    $   ./7-software-pacman.sh
    $   ./8-software-aur.sh
    $   ./9-setup.sh

### Reboot

    $   reboot
