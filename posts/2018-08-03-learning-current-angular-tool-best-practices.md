---
title: Learning Current Angular Tool Best Practices
date: 2018-08-03T23:39:00 -4:00
author: gabrewer
comments: true
categories: Development, Angular
tags: post
---

Over the last couple of weeks I have been diving back into Angular development using Angular 6 and ngrx.  One of the things that quickly became apparent is that now the best practices of installing JavaScript tools is to install them locally instead of globally to prevent version collisions.

When I first started I installed the angular cli globally and encountered this type of error when running many of the sample apps that I downloaded.

<!-- more -->

Your global Angular CLI version (6.0.8) is greater than your local version (1.7.3). The local Angular CLI version is used.

This didn’t seem to cause me an issues but still the error bugged me and when I was reading the book [Angular 6 for Enterprise-Ready Web Applications](https://web.archive.org/web/20180817225000/https://www.packtpub.com/web-development/angular-6-enterprise-ready-web-applications) by Doguhan Uluca he really drives home that you should keep the number of globally installed packages to a minimum.

I was able to find out what commands I had installed globally using this command

<pre class="highlight prettyprint">npm list -g --depth=0</pre>

Which showed I only had the angular cli and npm install globally.

So I was able to uninstall the global angular cli and get rid to the ugly warnings.

Doguhan also points our that you should use npm-windows-upgrade instead of using npm i -g npm to upgrade npm on Windows or you are going to run into npm corruption issues.

[https://github.com/felixrieseberg/npm-windows-upgrade](https://web.archive.org/web/20180817225000/https://github.com/felixrieseberg/npm-windows-upgrade "https://github.com/felixrieseberg/npm-windows-upgrade")
