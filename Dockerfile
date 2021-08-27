FROM centos:centos7
LABEL maintainer="maxmilio@kiv.zcu.cz" \
      org.opencontainers.image.source="https://github.com/maxotta/kiv-ds-docker"

RUN yum -y update ;\
    yum clean all ;\
    yum -y install \
        net-tools \
        mc

RUN yum -y install \
        openssh-server \
        openssh-clients \
        passwd \
        sudo; \
    yum clean all ;\
    mkdir /var/run/sshd ;\
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

RUN useradd --create-home -s /bin/bash vagrant ;\
    echo -e "vagrant\nvagrant" | (passwd --stdin vagrant) ;\
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant ;\
    chmod 440 /etc/sudoers.d/vagrant

RUN mkdir -p /home/vagrant/.ssh ;\
    chmod 700 /home/vagrant/.ssh
ADD https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys ;\
    chown -R vagrant:vagrant /home/vagrant/.ssh

RUN yum -y install \
        epel-release \
        avahi \
        avahi-tools \
        nss-mdns

COPY kiv-ds-startup.sh /etc
RUN chmod a+x /etc/kiv-ds-startup.sh

ENTRYPOINT ["/etc/kiv-ds-startup.sh", "10.0.1.0"]
