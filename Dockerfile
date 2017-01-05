#FROM registry.access.redhat.com/rhel7.3:latest
FROM centos:latest
MAINTAINER Udo Urbantschitsch <udo@urbantschitsch.com>

ENV GOVER=go1.7.linux-amd64

RUN yum -y update && \
    yum clean all

RUN curl -LO https://storage.googleapis.com/golang/$GOVER.tar.gz && \
    tar -xvf $GOVER.tar.gz && \
    rm -f $GOVER.tar.gz && \
    mv go /usr/local && \
    ln -s ./go/bin/go go