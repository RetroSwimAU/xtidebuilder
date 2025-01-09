FROM ubuntu:latest

VOLUME ["/src"]

RUN apt-get update && apt-get install make nasm upx-ucl subversion perl

ADD resources/xtide_build.sh /
ADD resources/options /


ENTRYPOINT ["sh","-c","/xtide_build.sh"]

