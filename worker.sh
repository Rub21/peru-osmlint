#!/usr/bin/env bash

DATA=/tmp
bbox=$1

echo "# Downloading Peru MBTiles..."
wget -O $DATA/peru.mbtiles.gz https://s3.amazonaws.com/mapbox/osm-qa-tiles/latest.country/peru.mbtiles.gz

echo "# Extracting peru..."
gunzip $DATA/peru.mbtiles.gz

echo "# Looking for bridges on a node..."
osmlint bridgeonnode --bbox=$bbox $DATA/peru.mbtiles > $DATA/bridgeonnode.json

echo "# Looking for crossing highways..."
osmlint crossinghighways --bbox=$bbox $DATA/peru.mbtiles > $DATA/crossinghighways.json

echo "# Looking for crossing highways and waterways ..."
osmlint crossingwaterwayshighways --bbox=$bbox $DATA/peru.mbtiles > $DATA/crossingwaterwayshighways.json

echo "# Looking for missing layers on bridges..."
osmlint missinglayerbridges --bbox=$bbox $DATA/peru.mbtiles > $DATA/missinglayerbridges.json

echo "# Looking for node ending near highways..."
osmlint nodeendingnearhighway --bbox=$bbox $DATA/peru.mbtiles > $DATA/nodeendingnearhighway.json

echo "# Looking for self intersecting highways..."
osmlint selfintersectinghighways --bbox=$bbox $DATA/peru.mbtiles > $DATA/selfintersectinghighways.json

echo "# Looking for unclosed ways..."
osmlint unclosedways --bbox=$bbox $DATA/peru.mbtiles > $DATA/unclosedways.json

echo "# Looking for Unconnected highways"
osmlint unconnectedhighways --bbox=$bbox $DATA/peru.mbtiles > $DATA/unconnectedhighways.json


echo "# Merging results..."
python utils/merge-geojson.py $DATA/bridgeonnode.json > $DATA/bridgeonnode.final.json
python utils/merge-geojson.py $DATA/crossinghighways.json > $DATA/crossinghighways.final.json
python utils/merge-geojson.py $DATA/crossingwaterwayshighways.json > $DATA/crossingwaterwayshighways.final.json
python utils/merge-geojson.py $DATA/missinglayerbridges.json > $DATA/missinglayerbridges.final.json
python utils/merge-geojson.py $DATA/nodeendingnearhighway.json > $DATA/nodeendingnearhighway.final.json
python utils/merge-geojson.py $DATA/selfintersectinghighways.json > $DATA/selfintersectinghighways.final.json
python utils/merge-geojson.py $DATA/unclosedways.json > $DATA/unclosedways.final.json
python utils/merge-geojson.py $DATA/unconnectedhighways.json > $DATA/unconnectedhighways.final.json


geojson-merge $DATA/*.final.json > $DATA/results.json

gist="`geojson-josm-url $DATA/results.json | gist -f results.json`"
url="https://hey.mapbox.com/peer-review/#$gist"

echo "# Delete temporary json files"
rm  $DATA/*.json
