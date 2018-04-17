#!/bin/node



let memberId = process.argv[1]
let url = 'https://api.crossref.org/members/`$memberId`?sample=1&filter=from-pub-date:`date +"%Y"`'



