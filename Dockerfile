FROM ubuntu:14.04

RUN apt-get update && apt-get install -y texlive-full
RUN apt-get install -y make pdftk

ADD kallelse.bash /tmp/kallelse.bash
ADD kallelse.pl /tmp/kallelse.pl
ADD Makefile /tmp/Makefile

RUN mkdir /tmp/out && mkdir /tmp/Private

WORKDIR /tmp
CMD make gen
