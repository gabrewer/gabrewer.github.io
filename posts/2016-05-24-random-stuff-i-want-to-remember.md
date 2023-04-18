---
title: Random Stuff I want to remember
date: 2016-05-24T23:39:00 -4:00
author: gabrewer
comments: true
categories: [Random]
tags: post
---

### Windows 10 Home password expiration.

Today I had a couple of Windows 10 Home machines had their passwords expire.

To turn off the Windows 10 password expiration

_net accounts /maxpwage:0_

From [http://www.thewindowsclub.com/customizing-the-password-policy-in-windows-7](http://www.thewindowsclub.com/customizing-the-password-policy-in-windows-7)

### Upgrading npm on Windows

I was installing jspm on a new machine and after I installed node 4.3.1 it was running npm I was trying to upgrade npm.  I tried a bunch of different commands I found on stack overflow but this command from the npm site (I feel like Colonel Sanders looking for the Nashville Hot Chicken Recipe) did the trick on both Windows and the Mac.

_npm install npm@latest –g_

From*:* [_https://docs.npmjs.com/getting-started/installing-node_](https://docs.npmjs.com/getting-started/installing-node "https://docs.npmjs.com/getting-started/installing-node")

### http-server

In my recent javascript library/framework exploration I found myself needing a quick way to server html without having to have gulp or more permanent web server.  I found http-server fits the bill nicely.

npm install –g http-server

http-server –o –c-1

-o opens browser window after starting the server

-c-1 disables caching

From: [https://github.com/indexzero/http-server](https://github.com/indexzero/http-server "https://github.com/indexzero/http-server")
