FROM ubuntu:22.04

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.ustc.edu.cn/g" /etc/apt/sources.list && \
    sed -i "s/http:\/\/security.ubuntu.com/http:\/\/mirrors.ustc.edu.cn/g" /etc/apt/sources.list

RUN apt-get update && \ 
    apt-get -y install openssh-server

RUN useradd -m ctf && echo "ctf:ctf" && \
    echo "ctf:ctf" | chpasswd --crypt-method SHA512 && \
    echo "root:bullshit" | chpasswd --crypt-method SHA512

RUN ssh-keygen -A && \
    /etc/init.d/ssh start && \
    chsh -s /bin/bash ctf

RUN chmod 777 /etc/passwd && \
    chmod 777 /etc/shadow

# COPY ./src/sudoers /etc/sudoers
COPY ./service/docker-entrypoint.sh /
COPY ./src/sshd_config /etc/ssh/sshd_config

ENTRYPOINT ["/bin/bash","/docker-entrypoint.sh"]