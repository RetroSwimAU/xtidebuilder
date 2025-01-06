FROM alpine:latest

VOLUME ["/src"]

RUN apk add --update bash make nasm upx subversion perl

ADD resources/xtide_build.sh /
ADD resources/options /


ENTRYPOINT ["sh","-c","/xtide_build.sh"]

