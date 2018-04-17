#!/bin/node

const fs = require('fs')



fs.readdir('db/raw/', (err, files) => {
  fs.writeFileSync('db/coverage-tidydata.csv', 'name,totaldois,type,coverage\n')
  files.forEach((file, err) => {
    fs.readFile(`db/raw/${file}`, (err, res) => {
      JSON.parse(res.toString()).message.items.forEach((body, err) => {
        let totaldois = body.counts['total-dois']
        let name = body['primary-name']
        let coverages = body.coverage
        let keys = Object.keys(coverages)
        let numbers = Object.values(coverages)

        for ( key in keys ) {
          fs.appendFileSync('db/coverage-tidydata.csv', 
            `"${name}",${totaldois},${keys[key]},${numbers[key]}\n`)
        }
      })
    })
  })
})