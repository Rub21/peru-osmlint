#!/usr/bin/env bash

# "Install tippecanoe dependencies"
apt-get install  -y libprotobuf-dev protobuf-compiler libsqlite3-dev

# Install ruby to install gist cli
apt-get install -y ruby

git clone https://github.com/mapbox/tippecanoe.git
cd tippecanoe
git checkout tags/1.4.2
make
make install

cd ..
git clone https://github.com/osmlab/osmlint.git
cd osmlint
npm install && npm link

gem install gist

npm install -g geojson-merge
npm install -g geojson-josm-url
npm install -g geojsonio-cli