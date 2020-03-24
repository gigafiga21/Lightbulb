# Lightbulb
Small linux distribution based on Linux From Scratch book v9.1.


## Requirements:
- Linux:
    - Git
    - Bash
    - Make
- Windows:
    - Git
    - Docker >= 17.06


## Building on non-Linux OS
To build Lightbulb on non-Linux machine you need VM or docker. In both cases you should put this folder into docker container or VM with Linux distro. For VM you can just clone this repo directly into Linux filesystem. Instructions for docker listed below - run following commands or setup VM and continue on building section.

### With makefile
Run following command from the root of repository:
```sh
make docker
cd lightbulb    # in container shell
```
This will run docker container with linux, mount root of repo in it and grant access to bash in container.

### Manually
Enter the root of repository and run manually commands from `make docker`:
```sh
docker build -t lightbulb-builder .
docker run -it \
    --name lightbulb \
    --mount type=bind,source="D:/Documents/Программирование/Bash/Lightbulb",destination=/lightbulb \
    lightbulb-builder

cd lightbulb    # in container shell
```


## Building

### Checking required packages
To check if you has all packages required for building on your linux machine run `make check`. This will list required packages and theirs state (installed/not installed and their versions). Notice that you should check versions of packages manually (requred versions will be listed). Also do not ignore `ERROR:` messages.

If your terminal has not color support set `NO_COLOR := 1` in Makefile or run `make NO_COLOR="1" [target_name]`.
