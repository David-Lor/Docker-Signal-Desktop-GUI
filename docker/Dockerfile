ARG IMAGE_TAG="debian-10"
ARG APP_ICON="https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Signal_ultramarine_icon.svg/600px-Signal_ultramarine_icon.svg.png"
#ARG APP_ICON="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Signal-Logo.svg/768px-Signal-Logo.svg.png"

FROM jlesage/baseimage-gui:${IMAGE_TAG}
ENV APP_NAME="Signal Messenger"

# Signal installation, based on steps from https://signal.org/es/download/# (Download for Linux)
RUN \
    # Dependencies for installation and for signal itself
    apt-get -yq update && apt-get -yq install wget gpg libgbm1 procps && \
    # 1. Install our official public software signing key
    wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg && \
    cat signal-desktop-keyring.gpg | tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null && \
    # 2. Add our repository to your list of repositories
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | tee -a /etc/apt/sources.list.d/signal-xenial.list && \
    # 3. Update your package database and install signal
    apt-get -yq update && apt-get -yq install signal-desktop && \
    # Cleanup
    apt-get -yq purge wget gpg && apt-get -yq autoremove && \
    rm -rf /var/lib/apt/lists/*

# Post-requirements for Signal
RUN chown root:root /opt/Signal/chrome-sandbox && chmod 4755 /opt/Signal/chrome-sandbox

# Set application icon
ARG APP_ICON
RUN install_app_icon.sh ${APP_ICON}

# Entrypoint script
COPY ./startapp.sh /startapp.sh

# Volumes definition
VOLUME ["/config"]
