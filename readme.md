# Yamano's dotfiles
My personal dotfile for linux and macos

## Requirements
- stow

## Config files management
### Setup
```sh
./setup
```
### Clean
```sh
./clean
```
### Customize
Add or remove file from `stow.list`

## Linux
### Install dependencies
```sh
sudo ./apt-install
```
### Customize
Add or remove file from `apt.list`

## MacOS
### Install dependencies
```sh
bash install-macos-app.sh
```
### Customize
Add or remove line from `install-macos-app.sh` installation script

## Tmux
We are using [tpm](https://github.com/tmux-plugins/tpm) plugin to setup tmux.o
You should install it and use command `prefix + I` to install it.
