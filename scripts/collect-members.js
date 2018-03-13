#!/bin/node

const https = require('https')
const sleep = require('sleep')
const fs = require('fs')

let base = 'https://api.crossref.org/members'
let id = 'mailto=info@libscie.org'
let pageLimit = 1000

let limit, interval, nrMembers
// get headers
https.get(`${base}?rows=0&${id}`, (req, err) => {
  if (err) throw err
  limit = parseInt(req.headers['x-rate-limit-limit'])
  interval = parseInt(req.headers['x-rate-limit-interval'].replace(/s/g, ''))
  req.on('data', (d) => {
    nrMembers = JSON.parse(d.toString()).message['total-results']
  })
})

// let i = 1
let off = 0

https.get(`${base}?rows=${pageLimit}&${id}&offset=${off}`, (req, err) => {
  if (err) throw err
  let body = ''
  req.on('data', (d) => {
    // console.log(Object(d.toString()))
    body = body.concat(d.toString())
    // console.log(body)
    // write away json
    fs.writeFile(`db/members_${off}.json`, body, 'utf8', (err) => {
      if (err) throw err
      console.log(`Successfully collected for members ${off}-${off + pageLimit}.`)
    })
  })
})

off += 1000
sleep.sleep(1)
