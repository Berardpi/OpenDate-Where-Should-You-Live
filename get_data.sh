#!/bin/bash

function process_file {
  sed -i '$ d' $1
  sed -i '1d' $1
  sed -i '1d' $1
}

function process_file_bis {
  sed -i '$ d' $1
  sed -i '1d' $1
  sed -i '1d' $1
}

# neighborhood
curl http://sig.grenoble.fr/opendata/Decoupage/json/UNIONS_DE_QUARTIER_EPSG4326.json > neighborhood.geojson
process_file "neighborhood.geojson"
mongoimport --jsonArray --host localhost:27017 --db wsil --collection neighborhood --drop --file neighborhood.geojson
rm neighborhood.geojson



# Cycle lane
curl http://metromobilite.fr/data/Carto/Statique/velo.geojson > cycle_lane.geojson
process_file "cycle_lane.geojson"
mongoimport --jsonArray --host localhost:27017 --db wsil --collection cyclelane --drop --file cycle_lane.geojson
rm cycle_lane.geojson


# Citelib
curl http://data.metromobilite.fr/api/bbox/json?types=citelib > citelib.geojson
sed -i 's/^.\{40\}//' citelib.geojson
sed -i '$s/..$//' citelib.geojson
mongoimport --jsonArray --host localhost:27017 --db wsil --collection citelib --drop --file citelib.geojson
rm citelib.geojson

# Stop
curl http://www.metromobilite.fr/data/Carto/Statique/ArretsLight.geojson > stop.geojson
process_file_bis "stop.geojson"
mongoimport --jsonArray --host localhost:27017 --db wsil --collection stop --drop --file stop.geojson
rm stop.geojson

# GSM
curl http://sig.grenoble.fr/opendata/Antenne_GSM/json/DSPE_ANT_GSM_EPSG4326.json > gsm.geojson
process_file "gsm.geojson"
mongoimport --jsonArray --host localhost:27017 --db wsil --collection gsm --drop --file gsm.geojson
rm gsm.geojson
