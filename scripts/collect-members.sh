#!/bin/bash

base='https://api.crossref.org/members'
ID='mailto=info@libscie.org'
pageLimit=1000
OFFSET=0

interval=`curl "${base}?rows=0&${ID}" -I | grep X-Rate-Limit-Interval | grep -oP '\d+'`
sleep ${interval}
limit=`curl "${base}?rows=0&${ID}" -I | grep X-Rate-Limit-Limit | grep -oP '\d+'`
sleep ${interval}
HITS=`curl "${base}?rows=0&${ID}" | jq '.["message"]["total-results"]'`
sleep ${interval}


while [ $OFFSET -lt $HITS ]; do
  curl "${base}?rows=${pageLimit}&${ID}&offset=${OFFSET}" > db/raw/members_${OFFSET}.json
  echo "Saved JSON for members $OFFSET and up in db/raw/members_${OFFSET}.json"
  let OFFSET=OFFSET+pageLimit  
  sleep ${interval}
done
