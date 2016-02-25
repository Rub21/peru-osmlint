#!/usr/bin/env bash

DATA=/tmp
urlmbtiles=$1
mbtilesFile=$(basename "$mbtilesUrl")
bbox=$2

echo "# Downloading  MBTiles...$mbtilesFile"
wget -O $DATA/$mbtilesFile @urlmbtiles

if [ ${mbtilesFile: -3} == ".gz" ]
then
  echo "# Extracting $mbtilesFile..."
  gunzip $DATA/$mbtilesFile
  mbtilesFile=${mbtilesFile::-3}
fi

echo "# Looking for bridges on a node..."
osmlint bridgeonnode --bbox=$bbox $DATA/$mbtilesFile > $DATA/bridgeonnode.json

echo "# Looking for crossing highways..."
osmlint crossinghighways --bbox=$bbox $DATA/$mbtilesFile > $DATA/crossinghighways.json

echo "# Looking for crossing highways and waterways ..."
osmlint crossingwaterwayshighways --bbox=$bbox $DATA/$mbtilesFile > $DATA/crossingwaterwayshighways.json

echo "# Looking for missing layers on bridges..."
osmlint missinglayerbridges --bbox=$bbox $DATA/$mbtilesFile > $DATA/missinglayerbridges.json

echo "# Looking for node ending near highways..."
osmlint nodeendingnearhighway --bbox=$bbox $DATA/$mbtilesFile > $DATA/nodeendingnearhighway.json

echo "# Looking for self intersecting highways..."
osmlint selfintersectinghighways --bbox=$bbox $DATA/$mbtilesFile > $DATA/selfintersectinghighways.json

echo "# Looking for unclosed ways..."
osmlint unclosedways --bbox=$bbox $DATA/$mbtilesFile > $DATA/unclosedways.json

echo "# Looking for Unconnected highways"
osmlint unconnectedhighways --bbox=$bbox $DATA/$mbtilesFile > $DATA/unconnectedhighways.json


echo "# Merging results..."
python utils/merge-geojson.py $DATA/bridgeonnode.json > $DATA/bridgeonnode.final.json
python utils/merge-geojson.py $DATA/crossinghighways.json > $DATA/crossinghighways.final.json
python utils/merge-geojson.py $DATA/crossingwaterwayshighways.json > $DATA/crossingwaterwayshighways.final.json
python utils/merge-geojson.py $DATA/missinglayerbridges.json > $DATA/missinglayerbridges.final.json
python utils/merge-geojson.py $DATA/nodeendingnearhighway.json > $DATA/nodeendingnearhighway.final.json
python utils/merge-geojson.py $DATA/selfintersectinghighways.json > $DATA/selfintersectinghighways.final.json
python utils/merge-geojson.py $DATA/unclosedways.json > $DATA/unclosedways.final.json
python utils/merge-geojson.py $DATA/unconnectedhighways.json > $DATA/unconnectedhighways.final.json

echo "# Generate gist..."

echo "- Bridge onnode..."
gist="`geojson-josm-url $DATA/bridgeonnode.final.json | gist -f bridgeonnode.final.json`"
url="http://rub21.github.io/geojson-dashboard/#$gist"
echo $url

echo "- Crossing highways..."
gist="`geojson-josm-url $DATA/crossinghighways.final.json | gist -f crossinghighways.final.json`"
url="http://rub21.github.io/geojson-dashboard/#$gist"
echo $url

echo "- Crossing waterways and highways..."
gist="`geojson-josm-url $DATA/crossingwaterwayshighways.final.json | gist -f crossingwaterwayshighways.final.json`"
url="http://rub21.github.io/geojson-dashboard/#$gist"
echo $url

echo "- Missing layer on bridges..."
gist="`geojson-josm-url $DATA/missinglayerbridges.final.json | gist -f missinglayerbridges.final.json`"
url="http://rub21.github.io/geojson-dashboard/#$gist"
echo $url

echo "- Node ending near highway..."
gist="`geojson-josm-url $DATA/nodeendingnearhighway.final.json | gist -f nodeendingnearhighway.final.json`"
url="http://rub21.github.io/geojson-dashboard/#$gist"
echo $url

echo "- Self intersecting highways..."
gist="`geojson-josm-url $DATA/selfintersectinghighways.final.json | gist -f selfintersectinghighways.final.json`"
url="http://rub21.github.io/geojson-dashboard/#$gist"
echo $url

echo "- Unclosedways..."
gist="`geojson-josm-url $DATA/unclosedways.final.json | gist -f unclosedways.final.json`"
url="http://rub21.github.io/geojson-dashboard/#$gist"
echo $url

echo "- Unconnected highways..."
gist="`geojson-josm-url $DATA/unconnectedhighways.final.json | gist -f unconnectedhighways.final.json`"
url="http://rub21.github.io/geojson-dashboard/#$gist"
echo $url

echo "# Delete temporary json files"
rm  $DATA/*.json