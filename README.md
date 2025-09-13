# Arch Linux Post Installation Setup and Config Scripts

```ascii
xdol:,'.';:cccccloddxkOOOOO0KKKKKKKKKXXKKKKK0OOOOO0KKKKKKKK0OkxkOOOkkkxddxxxddddoooddddoc:c:::::::::
::;,'',:cccclloodxkkOO0000KKKKKKKK0OkkkkkOO0OOOOO00KKKKKXKK00OkkOOOOkxdlc:;,'..',,,:cclllcc:::::::::
,,;:cclcllooodxkkOOO0KK0000Oxddoc:;,',,,,;::codxO00KKKKKXK000kxdkOkkkxol:'.......':c:',loc;;::::::::
;clolllloodxxkkOOOOkdolclllc::;'..''..'....,cloxk00KKKKKXXK0OxlcdOkOkxollc;,''',;cll;.'ldlc,,,;:::::
lllooloddxkOOOkoccc:;;:cldxxkkdc'.........'loloxkO0KKXXXXXK0OxllxOOOOkdc:oddddxxddoo;.,looc:'.';::::
dddddxxkkOO0OOx:;ldxkkkkkOOOOOOxl,......':oxocokO00KKXXXXXKK0koclk0OOkxo:cdxkkkxxxdo;.:loolc,..,::::
xxkkkOOO0000OOkc:dkkOOO00KK0KK0Okxl::;:ldxkxl:oOO00KKXXXXKKKKOdlokOOOkkdc:coxxxxxddc,;lloolc,',:::::
kOOO00KKKK00OOkl:okOO000KKKKKKKK00OOOOOOkkko;:xOOO0KKXXXXKKKKOxoodkOOkkxxolclodddo:;:llooll:'',;::::
O000KKKKKXK00Okd:cxk00KKKKKXXXKKKKKK000OOkd::dkkO0KKKXXKKKKK0Oxoc:cdkkxxxdolccccc::cllool:,',:,.,:::
0KKXXXXKKKKK0OOx:'ck0KKXKKKKXKKKKKKK00OOkd::oxxO0KKKKKKKKKKK0kdlc;',cdxddddoollllllllll:,.',;,..;:::
KKKXXXXXXXKK00Okdc:lxO0KKKKKKKKKKKK0000kl;cdxxk0KXXXXKKKKKK0Okoc::,.'cddddddddoooolc:,''',;,'..;::::
KKKXXXXXXXXXKK00OOkoodkO0000000KKK000Oolldxkkk00KKXXKKKXXXK0kd:';l:'.,lolooddoooc:,..';;;;,,,,,:::::
XKKXXXXXXXXXXXXXXKK0kdllloxkOOOOOkkxolldkkxk00KKKKKKKXXXXKKkoc;..::,..,::cccc:,'.',;;;,'',;::'':::::
KXXXXKXXXXXXXXXXXXXKK0kdoccllldddxdodxxkkkO000KKKKKKKXXKK0koc;'..,,'..'cc:,'''',;:;,'...';cc:..:::::
:cclloodxkO000KKKKKKK0000OkkxxkkkOOOkkkOOO00000KKXKKKK0Okxdoc:'..''....'''',;::;,....,;;::cc;..;::::
olc;,,,;:ccc:ccllllddddxxxxkkkOOOOkkkkkkkkkkkkkOO0Okkxddoll:;'.......';;:::;,,....',;;:::cll;. .';::
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

```shell
./1-hardware.sh
./2-xfce.sh 
./3-network.sh 
./4-bluetooth.sh 
./5-audio.sh 
./6-printers.sh 
./7-software-pacman.sh
./8-software-aur.sh
./9-setup.sh
```

### Reboot

```shell
sudo systemctl reboot
```
