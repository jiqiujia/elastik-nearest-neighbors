#!/bin/sh
# Script for quickly recompiling and testing the elasticsearch-aknn plugin.
set -e

ESBIN="$HOME/elastic-stack/elasticsearch-5.6.5/bin"
PLUGINPATH="file:`pwd`/build/distributions/elasticsearch-aknn-0.0.1-SNAPSHOT.zip"

# TODO: fix the code so that skipping these tasks is not necessary.
gradle clean build -x integTestRunner -x test
$ESBIN/elasticsearch-plugin remove elasticsearch-aknn | true
$ESBIN/elasticsearch-plugin install -b $PLUGINPATH

sudo sysctl -w vm.max_map_count=262144
export ES_HEAP_SIZE=12g
$ESBIN/elasticsearch
