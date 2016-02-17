## Error detection in OpenStreetMap

This repository shows an easy way to detect errors in OSM using [osmlint](https://github.com/osmlab/osmlint) and [osm-qa-tiles](http://osmlab.github.io/osm-qa-tiles/)

### Clone the repository

`git clone https://github.com/Rub21/peru-osmlint.git`

### Install dependencies

```sh
peru-osmlint$ sudo ./install.sh
```
### Obtain data
[osmlint](https://github.com/osmlab/osmlint) works with the data produced by [osm-qa-tiles](http://osmlab.github.io/osm-qa-tiles/).
You can get MBtiles data of the [planet](http://osmlab.github.io/osm-qa-tiles/) or the MBtiles data by [contry](http://osmlab.github.io/osm-qa-tiles/country.html)

For this example I will use [peru.mbtiles](https://s3.amazonaws.com/mapbox/osm-qa-tiles/latest.country/peru.mbtiles.gz)


### Get the bounding box for Peru.


You can use the [wiki](http://wiki.openstreetmap.org/wiki/User:Ewmjc/Country_bounds) for the Bbox or this [page](http://lxbarth.com/bbox/#-81.462250,-18.417079,-68.542328, 0.24169850,5,-8.53756535080403,-68.43246459960936) as well, just select with the mouse the place you want to work and copy the coordinates that appear within the URL.
e.g

`-81.462250,-18.417079,-68.542328,0.24169850`


### Execute the comands

To run all validators you can run the following command.

`./worker.sh peru.mbtiles "[-81.462250,-18.417079,-68.542328,0.24169850]"`

If in case you want to run the validator separately, you can do the following.

```sh
osmlint crossinghighways --bbox="[-81.462250,-18.417079,-68.542328,0.24169850]"  /tmp/peru.mbtiles > /tmp/crossinghighways.json
python utils/merge-geojson.py /tmp/crossinghighways.json > /tmp/crossinghighways.final.json
geojson-josm-url /tmp/crossinghighways.final.json | gist -f crossinghighways.final.json

```

the output will be  a gist URL: https://gist.github.com/7bd40a110f8118e753e3

if you want to see these errors in [mapbox-peer-review](https://hey.mapbox.com/peer-review/) plataforn, you can add the url after Gist ater the plataform url.
e.g

https://hey.mapbox.com/peer-review/#https://gist.github.com/7bd40a110f8118e753e3