##Error detection in OpenStreetMap

This repository shows an easy way to detect errors in OSM using [osmlint](https://github.com/osmlab/osmlint) and [osm-qa-tiles](http://osmlab.github.io/osm-qa-tiles/)

### Clone the repository

`git clone https://github.com/Rub21/peru-osmlint.git`

### Install dependencies

```sh
peru-osmlint$ sudo ./install.sh
```
### Obtain data
You can download the planet MBTiles data [here](http://osmlab.github.io/osm-qa-tiles/), or MBtiles per [contry](http://osmlab.github.io/osm-qa-tiles/country.html) as well.  For this example I will use [peru.mbtiles](https://s3.amazonaws.com/mapbox/osm-qa-tiles/latest.country/peru.mbtiles.gz)


### Get the bounding box for Peru.

For this I use this [wiki](http://wiki.openstreetmap.org/wiki/User:Ewmjc/Country_bounds) or this [page](http://lxbarth.com/bbox/#-81.462250,-18.417079,-68.542328, 0.24169850,5,-8.53756535080403,-68.43246459960936) as well, simply copy the last part after bbox.

`-81.462250,-18.417079,-68.542328,0.24169850`


### Execute the app

`./worker.sh peru.mbtiles "[-81.462250,-18.417079,-68.542328,0.24169850]"`