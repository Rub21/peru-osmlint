## Error detection in OpenStreetMap

This repository shows an easy way to detect errors in OSM using [osmlint](https://github.com/osmlab/osmlint) and [osm-qa-tiles](http://osmlab.github.io/osm-qa-tiles/)

### Clone the repository

`git clone https://github.com/Rub21/peru-osmlint.git`

### Install dependencies

```sh
peru-osmlint$ sudo ./install.sh
```
### Obtaining data
[osmlint](https://github.com/osmlab/osmlint) works with the data produced by [osm-qa-tiles](http://osmlab.github.io/osm-qa-tiles/).
You can get MBtiles data from the [planet](http://osmlab.github.io/osm-qa-tiles/) or the MBtiles data by [contry](http://osmlab.github.io/osm-qa-tiles/country.html)

For this example I will use [peru.mbtiles](https://s3.amazonaws.com/mapbox/osm-qa-tiles/latest.country/peru.mbtiles.gz)


### Getting the bounding box for Peru.


You can use the [wiki](http://wiki.openstreetmap.org/wiki/User:Ewmjc/Country_bounds) for the Bbox or this [page](http://lxbarth.com/bbox/#-81.462250,-18.417079,-68.542328,0.24169850,5,-8.53756535080403,-68.43246459960936) as well,  use the mouse to select  places you want to work on and copy the coordinates that appear within the URL.
e.g

`-81.462250,-18.417079,-68.542328,0.24169850`


### Executing the comands

To run all validators you can use the following command.

`./worker.sh peru.mbtiles "[-81.462250,-18.417079,-68.542328,0.24169850]"`

In case you want to run the validator separately, you can use the  following commands.

```sh
osmlint crossinghighways --bbox="[-81.462250,-18.417079,-68.542328,0.24169850]"  /tmp/peru.mbtiles > /tmp/crossinghighways.json
python utils/merge-geojson.py /tmp/crossinghighways.json > /tmp/crossinghighways.final.json
geojson-josm-url /tmp/crossinghighways.final.json | gist -f crossinghighways.final.json
```


the output will be  a gist URL: https://gist.github.com/7bd40a110f8118e753e3

### Result


```
- Bridge onnode
http://rub21.github.io/geojson-dashboard/#https://gist.github.com/17bfc6999ea1d2452f05
- Crossing highways...
http://rub21.github.io/geojson-dashboard/#https://gist.github.com/0061533a1b1369f2523a
- Crossing waterways and highways...
http://rub21.github.io/geojson-dashboard/#https://gist.github.com/ed6fdd7b37cf283731ff
- Missing layer on bridges...
http://rub21.github.io/geojson-dashboard/#https://gist.github.com/05a6ec4d263569d40d66
- Node ending near highway...
http://rub21.github.io/geojson-dashboard/#https://gist.github.com/e593889b973c221aafe8
- Self intersecting highways...
http://rub21.github.io/geojson-dashboard/#https://gist.github.com/ed2e30864fb1447d1de0
- Unclosedways...
http://rub21.github.io/geojson-dashboard/#https://gist.github.com/3c282c6eba5d067baff2
- Unconnected highways...
http://rub21.github.io/geojson-dashboard/#https://gist.github.com/40b38e802556f94f41d9

```
To see these errors on a dashboard, you can use this [fork](https://github.com/Rub21/geojson-dashboard) form [geojson-dashboard](https://github.com/fulcrumapp/geojson-dashboard).

- [Bridges on a node](http://rub21.github.io/geojson-dashboard/#https://gist.github.com/17bfc6999ea1d2452f05)
- [Crossing highways](http://rub21.github.io/geojson-dashboard/#https://gist.github.com/0061533a1b1369f2523a)
- [Crossing waterways and highways](http://rub21.github.io/geojson-dashboard/#https://gist.github.com/ed6fdd7b37cf283731ff)
- [Missing layer on bridges](http://rub21.github.io/geojson-dashboard/#https://gist.github.com/05a6ec4d263569d40d66)
- [Node ending near highway](http://rub21.github.io/geojson-dashboard/#https://gist.github.com/e593889b973c221aafe8)
- [Self intersecting highways](http://rub21.github.io/geojson-dashboard/#https://gist.github.com/ed2e30864fb1447d1de0)
- [Unclosedways](http://rub21.github.io/geojson-dashboard/#https://gist.github.com/3c282c6eba5d067baff2)
- [Unconnected highways](http://rub21.github.io/geojson-dashboard/#https://gist.github.com/40b38e802556f94f41d9)
