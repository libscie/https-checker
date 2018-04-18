#!/bin/bash

base='https://api.crossref.org/members'
ID='mailto=info@libscie.org'
YYYY=2017
RESULTS=`curl "${base}?rows=0&${ID}" | jq '.["message"]["total-results"]'`
echo "member-id,publisher,prefix,pubs-since-2017,doi-checked,force-https" > db/https-summary.csv

for i in `cat db/member-ids`; 
do
  MMBR=`curl ${base}/${i}/works?filter=from-pub-date:${YYYY}&sample=1`
  if [[ ${MMBR} != 'Resource not found.' ]]; then
    mkdir -p db/members/${i}
    PUB=`echo $MMBR | jq '.["message"]["items"][]["publisher"]' | tail -n 1`
    PREFIX=`echo $MMBR | jq '.["message"]["items"][]["prefix"]' | tail -n 1`
    DOI=`echo $MMBR | jq '.["message"]["items"][]["DOI"]' | tail -n 1`
    RES=`echo $MMBR | jq '.["message"]["total-results"]'`
    
    # run pshtt for sampled link
    pshtt --json doi.org/${DOI//'"'/''} | jq '.[]' > db/members/${i}/data.json
    
    if `cat db/members/${i}/data.json | jq '.["Redirect"]'`; then
      URL=`cat db/members/${i}/data.json | jq '.["Redirect To"]'`
      pshtt --json ${URL//'"'/''} | jq '.[]' > db/members/${i}/data.json
    fi
  
    HTTPS=`cat db/members/${i}/data.json | jq '.["Defaults to HTTPS"]'`
    
    if [[ $MMBR =~ .*total-results\":0.* ]]
      then
      echo ${i},null,null,0,null,null >> db/https-summary.csv
    else
      echo ${i},${PUB},${PREFIX},${RES},${DOI},${HTTPS} >> db/https-summary.csv
    fi
    echo "**************************************"
    echo "Collected information for member #${i}"
    echo "**************************************"
  else
    echo ${i},null,null,null,null,null >> db/https-summary.csv
  fi
done

