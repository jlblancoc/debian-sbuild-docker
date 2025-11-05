# --------------------------------------------
# Dockerfile: Debian sbuild environment setup
# --------------------------------------------

# Start from the Debian base image
FROM debian:unstable

# Maintainer info
LABEL maintainer="Jose Luis Blanco-Claraco <jlblanco@ual.es>"
LABEL description="Debian sbuild environment with development tools and bash autocomplete"

# ------------------------------------------------------------
# Step 1: Update system and configure subuid/subgid for root
# ------------------------------------------------------------
RUN apt-get update && \
    echo "root:100000:65536" >> /etc/subuid && \
    echo "root:100000:65536" >> /etc/subgid

# ------------------------------------------------------------
# Step 2: Install essential tools and sbuild environment
# ------------------------------------------------------------
RUN apt-get install -y devscripts sbuild git cmake sudo && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Step 3: Create the sbuild chroot
# ------------------------------------------------------------
# This command automatically generates /etc/schroot/chroot.d/unstable-amd64-sbuild
RUN sbuild-createchroot unstable /srv/chroot/unstable-amd64-sbuild http://deb.debian.org/debian

# ------------------------------------------------------------
# Step 4: Install bash autocomplete for convenience
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y bash-completion && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Step 5: Default shell and working directory
# ------------------------------------------------------------
WORKDIR /root
CMD ["/bin/bash"]
