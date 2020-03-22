# Lightbulb
Small linux distribution based on Linux From Scratch book.


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
