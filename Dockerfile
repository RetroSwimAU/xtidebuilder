FROM debian:bookwork-backports

VOLUME ["/src"]

RUN apt-get update && apt-get -y install make nasm upx-ucl subversion perl ca-certificates

ADD resources/xtide_build.sh /
ADD resources/options /

ENTRYPOINT ["sh","-c","/xtide_build.sh"]

