FROM ubuntu:vivid
MAINTAINER Jesse Osiecki <jesse.osiecki@solarwinds.com>
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg --add-architecture i386 
RUN apt-get update
RUN apt-get install -y firefox:i386 icedtea-7-plugin:i386 \
    openjdk-7-jre:i386 libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 \
    libxft2:i386 libxmu6:i386 libxv1:i386 fonts-takao
RUN apt-get install libgtk2.0-0:i386 libxtst6:i386 libdbus-glib-1-2:i386 -y && \
    apt-get install lib32stdc++6 libasound2 -y && \
    apt-get install -y libpulse0:i386 pulseaudio:i386 && \
    apt-get install -y pulseaudio && echo enable-shm=no >> /etc/pulse/client.conf

RUN useradd -ms /bin/bash webex
USER webex
WORKDIR /home/webex
#ADD ./jre1.7.0_80  jre
#ADD ./jre1.8.0_144  jre
#RUN mkdir -p ~/.mozilla/plugins/
#RUN ln -sf $HOME/jre/lib/i386/libnpjp2.so $HOME/.mozilla/plugins/
RUN rm -rf $HOME/.webex/
CMD ["/usr/bin/firefox", "https://sw.webex.com/"]
