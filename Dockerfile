FROM debian:11

RUN apt-get update && apt-get install -y \
    openssh-server sudo vim iproute2 net-tools python3 iputils-ping lsb-release \
    && mkdir /var/run/sshd \
    && useradd -m developer \
    && echo 'developer:1111' | chpasswd \
    && adduser developer sudo \
    && echo 'root:1111' | chpasswd \
    && mkdir -p /home/developer/.ssh \
    && echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkIBm/vjcCocLxO2TvqAz/hofd93q1A0yMRT5C2Gspu deploy@example.dev" >> /home/developer/.ssh/authorized_keys \
    && chown -R developer:developer /home/developer/.ssh \
    && chmod 700 /home/developer/.ssh \
    && chmod 600 /home/developer/.ssh/authorized_keys \
    && service ssh restart

EXPOSE 22 80
CMD ["/usr/sbin/sshd", "-D"]
