# HTTPS-checker

This repository checks scholarly publishers and preprint archives for their HTTP(S) status. 

## The risk

When websites are HTTP, they do encrypt the traffic. That way, anyway who gets in between can change content (a Man In The Middle; or MITM) without the user realizing. On the flipside, any content the user inputs (say: passwords) are unsecured and can be eavesdropped by anyone. BOOOOO! 😠

## The progress

HTTPS anno 2018 is still the minority of webpages. Old webpages need to be upgraded, and new ones need to get certificates (I know, I was a sysadmin for some pages that had HTTP way too long!). Initiatives like [CertBot]() and [Let's Encrypt]() make it radically easy to upgrade most pages though.

There is no longer an excuse for websites that attract substantial traffic, require users to input information (any kind), and depend on content integrity to not be HTTPS.

Scholarly publishers need to have all of these --- they need to have HTTPS is the idea. But we cannot hold them accountable or recognize their valiant efforts to upgrade to HTTPS if we don't monitor it. That's what this repository will do.

## The process

We try to do as little manually as possible, because we're lazy and because we make mistakes. We also make mistakes in our code, so please help us audit our code in this repository, if you can!

Our pipeline is as follows:

- Collect prefix locations of DOIs in CrossRef and DataCite 
- Resolve these prefixes to their domain
- Check whether the domain is HTTPS by default, allows HTTP, or has HTTPS when forced
- Rerun this simple check daily and log it in a public, CC 0 Public Domain Dedicated database
- Showcase all this glorious data in a front-end for anyone to track their favorited or most hated publisher(s)

## The status

This project just started. So this is it.