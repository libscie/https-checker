# HTTPS-checker

This repository checks scholarly publishers and preprint archives for their HTTP(S) status. Upon initial full version it will be ported to the [Liberate Science](https://github.com/libscie) organization account.

## The risk

When websites are HTTP, they do not encrypt the traffic. That way, anyway who gets in between can change content (a Man In The Middle; or MITM) without the user realizing. On the flipside, any content the user inputs (say: passwords) are unsecured and can be eavesdropped by anyone. BOOOOO! 😠

![Science Magazine does not have HTTPS!](assets/http-example.png)

## The progress

HTTPS anno 2018 is still the minority of webpages. Old webpages need to be upgraded, and new ones need to get certificates (I know, I was a sysadmin for some pages that had HTTP way too long!). Initiatives like [CertBot]() and [Let's Encrypt]() make it radically easy to upgrade most pages though.

There is no longer an excuse for websites that attract substantial traffic, require users to input information (any kind), and depend on content integrity to not be HTTPS.

Scholarly publishers need to have all of these --- they need to have HTTPS is the idea. But we cannot hold them accountable or recognize their valiant efforts to upgrade to HTTPS if we don't monitor it. That's what this repository will do.

## The process

We try to do as little manually as possible, because we're lazy and because we make mistakes. We also make mistakes in our code, so please help us audit our code in this repository, if you can!

Our pipeline is as follows:

- [Collect members](scripts/collect-prefixes.js) of [CrossRef](https://github.com/CrossRef/rest-api-doc) and [DataCite](https://support.datacite.org/docs/api)
- [Match members to a URL](scripts/collect-members.js) (see issue #2)
- [Check whether the domain is HTTPS by default, allows HTTP, or has HTTPS when forced](https://github.com/dhs-ncats/pshtt) (see also issue #1)
- Rerun this simple check daily and log it in a public, CC 0 Public Domain Dedicated database 
- Showcase all this glorious data in a front-end for anyone to track their favorited or most hated publisher(s)

### Dependencies

Please ensure to have the following dependencies installed:

* [`pshtt`](https://github.com/dhs-ncats/pshtt); `pip install --user pshtt`

## Code of conduct

This project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms. We welcome you with open arms if you are mindful and respectful of differences. You might not always understand another person's perspective; acknowledging that other people's feelings or perspectives are valid regardless of your understanding is prerequisite number one to being both mindful and respectful. We will not consider contributions if they are not done in a respectful manner, no matter how "genius" they might be.
