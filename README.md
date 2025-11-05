# debian-sbuild-docker

## 🛠 How to Build the Docker Image

In a terminal from this directory:

```bash
docker build -t debian-sbuild .
```

This will create an image named debian-sbuild.

## 🧭 How to Run (Login) into the Container

To start the container interactively with the necessary privileges:

```bash
docker run --cap-add=SYS_ADMIN --security-opt seccomp=unconfined --rm -it debian-sbuild
```

## Actual build

Example:

```bash
dget https://.../foo.dsc

sbuild --chroot-mode=autopkgtest  \
  --autopkgtest-virt-server=autopkgtest-virt-null  \
  --extra-repository='deb http://deb.debian.org/debian experimental main' \
  --build-dep-resolver=aspcud  --aspcud-criteria '-count(down),-count(changed,APT-Release:=/experimental/),-removed,-changed,-new' \
  --add-depends 'liboctomap-dev (> 1.10)' -d unstable fcl_0.7.0-3.dsc \
  --append-to-version=.1 -m sbuild

# --extra-package ..
```
​​