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
    cd /usr/local/bin && \
    ln -s ../go/bin/go go

ENV GOROOT=/usr/local/go

###############################
ENV METRICBEAT_VERSION=5.1.1
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz && \
    tar -xvvf metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz && \
    rm metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz && \
    mv metricbeat-${METRICBEAT_VERSION}-linux-x86_64/ /metricbeat && \
    mv /metricbeat/metricbeat /bin/metricbeat && \
    chmod +x /bin/metricbeat && \
    mkdir -p /metricbeat/config /metricbeat/data && \
    chown -R 0:0 /metricbeat && \
    chmod -R g+rwx /metricbeat

WORKDIR /metricbeat

ADD container-files /

ENV ELASTICSEARCH_URL=elasticsearch

CMD /start.sh