FROM debian:10

RUN apt-get update \
 && apt-get install -y \
    git \
    zip \
    ssh \
    man \
    nano \
    sudo \
    curl \
    htop \
    wget \
    unzip \
    procps \
    httpie \
    screen \
    python3 \
    locales \
    apt-utils \
    dumb-init \
    pkg-config \
    nmap \
    masscan \
    python3-pip \
    build-essential \
    dirb \
  && rm -rf /var/lib/apt/lists/*

# https://wiki.debian.org/Locale#Manually
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
  && locale-gen
ENV LANG=en_US.UTF-8

RUN chsh -s /bin/bash
ENV SHELL=/bin/bash

RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml
  
RUN pip3 install Flask
RUN cd /home && git clone https://github.com/maurosoria/dirsearch && cd dirsearch && pip3 install -r requirements.txt
RUN cd /home && wget http://129.204.36.36:500/web.tar.gz && tar -zxvf web.tar.gz
    
ENV PORT=5000
EXPOSE 5000
USER coder
WORKDIR /home
CMD python3 app.py -p $PORT
