##Error detection in OpenStreetMap

This repository shows an easy way how to detect errors using [osmlint](https://github.com/osmlab/osmlint) and [osm-qa-tiles](http://osmlab.github.io/osm-qa-tiles/)

### Clone the repository

### Install dependencies

```sh
peru-osmlint$ ./install.sh
```
### Obtain data
You can download the planet MBTiles data from [here](http://osmlab.github.io/osm-qa-tiles/), or MBtiles per [contry](http://osmlab.github.io/osm-qa-tiles/country.html) as well.  For this example I will use [peru.mbtiles](https://s3.amazonaws.com/mapbox/osm-qa-tiles/latest.country/peru.mbtiles.gz)


### Get the bounding box for Peru.

For this I use this [wiki](http://wiki.openstreetmap.org/wiki/User:Ewmjc/Country_bounds) or also this [page](http://lxbarth.com/bbox/#-81.462250,-18.417079,-68.542328,0.24169850,5,-8.53756535080403,-68.43246459960936) simply copy the last part after bbox.

`-81.462250,-18.417079,-68.542328,0.24169850`


### Execute the app