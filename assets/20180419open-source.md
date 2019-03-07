---
title: "HTTPS checking of scholarly publishers"
author: "Chris Hartgerink"

---

Scholarly publishers play a major role in the dissemination of scholarly information. As a society, we need to be able to rely on these publishers to provide that information securely, accurately, and with content integrity. We also want to be ensured that the information we provide is secure too (e.g., passwords). In this way, scholarly publishers have a responsibility towards the scholarly community because [publishing has become increasingly centralized](https://doi.org/10.1371/journal.pone.0127502).

Anecdotally, I was amazed how often scholarly publisher's pages are HTTP only. Implementing HTTPS has become much easier with initiatives such as [Let's Encrypt](https://letsencrypt.org/) and [Certbot](https://certbot.eff.org/) (but I recognize legacy systems can make it more difficult). As a scholar, I am primarily concerned with content integrity. This is essential when conducting systematic reviews, meta-analyses, or simply reading research and planning new studies. As a person, I am concerned about my and those of my colleagues' login credentials. Given that passwords are often reused, HTTP based publisher pages are also a threat to the credentials of scholars visiting the pages of scholarly publishers.

In order to hold the disseminators of scholarly information accountable, we need to be able to recognize whether this is a widespread issue and where improvements can be made. I find it disconcerting that one of the most acclaimed journals (Science Magazine) considers HTTP good enough and does not make a statement about why it has not upgraded yet. But there are many more publishers that also have the same responsibility towards their user.

By checking the websites of the publishers indexed by [CrossRef](https://crossref.org), the main metadata store for scholarly publications, we can get a sense of the scope of the problem. Today, there are approximately [10,000 members](https://api.crossref.org/members?rows=0) in CrossRef, of which ~8600 are still active ([taking having published in 2017 as being active](http://api.crossref.org/works?filter=from-pub-date:2017&facet=publisher-name:*&rows=0)). 

The project not only canvasses the scholarly publisher's landscape for HTTPS, it is also a precursor to actually trying to improve the situation. By being able to identify those publishers who publish the largest body of work in an unsecure way, we can start a dialogue with them to improve the situation. Previously, I have had constructive dialogue with [Collabra](https://collabra.org), who upgraded their webpage to default to HTTPS after my contacting them. If publishers take a more negligent, waving position, this also needs to be known because it belittles the security of the users and their role in accurate content presentation. In the long run, it will hurt the publishers too: [Chrome is starting to label pages as not secure if they use HTTP very soon](https://security.googleblog.com/2018/02/a-secure-web-is-here-to-stay.html).

<3: Details on open-source aspects + your latest progress>

```{r echo = FALSE}
dat <- read.csv('20180419open-source/data.csv')
fls <- sum(dat$force.https == 'false')
tr <- sum(dat$force.https == 'true')
nll <- sum(dat$force.https == 'null')
prcnt <- round(tr / (tr + fls) * 100, 0)
txt <- ifelse(prcnt >= 10 | prcnt <= 44, 'similar', ifelse(
  prcnt < 10, 'worse', 'better'))
```

The project just completed the initial data collection phase. By using [`pshtt`](https://github.com/dhs-ncats/pshtt), an open-source HTTPS testing tool, and a set of calls to the [CrossRef API](https://github.com/CrossRef/rest-api-doc) it was relatively easy to [script an initial canvas](https://github.com/chartgerink/https-checker/blob/master/scripts/https-checker.sh) of the publisher's security practices. 

| Active, default HTTPS | Active, not default HTTPS | Inactive |
| --------------------- | ------------------------- | -------- |
| `r tr` | `r fls` | `r nll` |

At first glance, `r prcnt`% of all `r tr + fls` active publishers default to HTTPS. In general, estimates of Websites that default to HTTPS range between [10-44%](https://www.usenix.org/system/files/conference/usenixsecurity17/sec17-felt.pdf). In other words, scholarly publishers seem to do `r txt` at securing their webpages.

<!-- scp -i ~/keys/nanopub-ami-key.pem admin@ec2-18-195-231-68.eu-central-1.compute.amazonaws.com:/home/admin/https-checker/db/https-summary.csv /home/chjh/writing/20180419open-source/data.csv -->

<!-- Predicting the defaulting of https using -->

<4: What's ahead for the project + its impact on the web>

Next for this project is opening up the dialogue with some of the largest publishers that do not provide HTTPS by default.  

The HTTPS scan however goes much deeper than just checking whether the page defaults to HTTPS. Other practices can help improve security even more. For example, the preloading of a HTTP Strict Transport Security (HSTS) header can help mitigate man-in-the-middle attacks. By using in-depth assessments of the webpages, improvements for websites that already default to HTTPS can be identified, improving their security even more. 

An increased uptake of more secure practices in content transfer on webpages is key to a secure Web, which ultimately affects the users that rely on the information transferred over the Internet. 


* visual browsing interface
* more in depth HTTPS scores
* relations between publisher characteristics and security
  * logistic regression
* Dat angle
https://github.com/beakerbrowser/beaker/wiki/Dat-DNS-TXT-records-with-optional-DNS-over-HTTPS