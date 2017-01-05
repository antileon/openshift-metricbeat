#!/bin/bash

if [ $ELASTICSEARCH_URL ]; then
    # wait for elasticsearch to start up
    ELASTIC_PATH=${ELASTICSEARCH_URL:-elasticsearch:9200}
    echo "Configure ${ELASTIC_PATH}"

    counter=0
    while [ ! "$(curl $ELASTIC_PATH 2> /dev/null)" -a $counter -lt 30  ]; do
      sleep 1
      let counter++
      echo "waiting for Elasticsearch to be up ($counter/30)"
    done

    curl -XPUT "http://$ELASTIC_PATH/_template/metricbeat" -d@/metricbeat/metricbeat.template-es2x.json
fi

metricbeat -e -v -c /metricbeat/metricbeat.yml