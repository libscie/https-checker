#!/bin/bash

base='https://api.crossref.org/members'
ID='mailto=info@libscie.org'
YYYY=2017
RESULTS=`curl "${base}?rows=0&${ID}" | jq '.["message"]["total-results"]'`
echo "publisher,doi-checked,force-https" > db/https-summary.csv

for ((i=1; i<=RESULTS; i++)); 
do
  MMBR=`curl ${base}/${i}/works?filter=from-pub-date:${YYYY}&sample=1`
  if [[ ${MMBR} != 'Resource not found.' ]]; then
    mkdir -p db/members/${i}
    PUB=`echo $MMBR | jq '.["message"]["items"][]["publisher"]' | tail -n 1`
    DOI=`echo $MMBR | jq '.["message"]["items"][]["DOI"]' | tail -n 1`
    
    # run pshtt for sampled link
    pshtt --json doi.org/${DOI//'"'/''} | jq '.[]' > db/members/${i}/data.json
    
    if `cat db/members/${i}/data.json | jq '.["Redirect"]'`; then
      URL=`cat db/members/${i}/data.json | jq '.["Redirect To"]'`
      pshtt --json ${URL//'"'/''} | jq '.[]' > db/members/${i}/data.json
    fi
  
    HTTPS=`cat db/members/${i}/data.json | jq '.["Domain Enforces HTTPS"]'`
    
    if [[ $MMBR =~ .*total-results\":0.* ]]
      then
      echo "Taking a rest."
    else
      echo ${PUB},${DOI},${HTTPS} >> db/https-summary.csv
      echo "**************************************"
      echo "Collected information for member #${i}"
      echo "**************************************"
    fi
  fi
done

