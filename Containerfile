FROM registry.fedoraproject.org/fedora:33
MAINTAINER Dave Baker <dbaker@redhat.com>

# xeyes is in here to help with debugging X access
# iputils (ping) to confirm/determine if we have networking enabled
# xauth to debug connectivity
RUN set -x && \
    dnf -y install --setopt=skip_missing_names_on_install=False \
           fedora-workstation-repositories dnf-plugins-core       && \
    dnf config-manager --set-enabled google-chrome                && \
    rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux         && \
    dnf -y install --setopt=skip_missing_names_on_install=False \
           xauth iputils xeyes               \
           google-chrome-stable              \
           flash-plugin                                           && \
    dnf -y install terminus-fonts google-noto-sans-fonts google-noto-serif-fonts gnu-free-serif-fonts gnu-free-mono-fonts gnu-free-sans-fonts root-fonts xorg-x11-fonts-ISO8859-2-100dpi xorg-x11-fonts-ISO8859-2-75dpi liberation-sans-fonts.noarch xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi                   && \
    dnf -y update -y && \
    dnf clean all && \
    rm -rf /var/cache/yum




# No persistent data expected to be preserved between runs
## VOLUME (none)

RUN useradd user
USER user

WORKDIR /home/user
COPY wrapper.sh .


# CMD ["/usr/bin/google-chrome"]
CMD ["/home/user/wrapper.sh"]


