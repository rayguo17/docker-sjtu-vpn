FROM ubuntu:20.04

# install package
RUN apt update && \
    apt install -y --no-install-recommends strongswan \
    libstrongswan-extra-plugins libcharon-extra-plugins\
    curl ca-certificates wget&&\
    apt install -y resolvconf ||\
    ln -s /etc/ssl/certs/* /etc/ipsec.d/cacerts/
    

COPY ./ipsec.* /etc/

COPY docker-entrypoint.sh /usr/local/bin

RUN curl -L https://raw.githubusercontent.com/snail007/goproxy/master/install_auto.sh | bash

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "start" ]





#when install resolvconf have problem 
# cause by default docker use resolv.conf to help with dns between host network and container network, so the file would be mounted from host, we can modify it, but cannot replace it!
#https://github.com/moby/moby/issues/1297 link about this issue

#cannot do ipsec start cause apparmor in manjaro(host) is blocking something to be execute in container so we would need to disable docker-default, or change to complain mode so that we could know what is being complain

# we then just add --privileged flag with docker run, then can use ipsec start to start ipsec



#cacerts problem need two certificates copy it

# authentication method use eap-gtc
# ipsec route 

# can use vpn traffic but since we cannot replace /etc/resolv.conf we need to add nameserver manually can we customize ipsec config to do it by adding not replacing?