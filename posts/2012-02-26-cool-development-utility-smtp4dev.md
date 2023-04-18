---
title: Cool Development Utility - smtp4dev
date: 2012-02-26T23:37:00 -4:00
author: gabrewer
comments: true
categories: [Development, Tools]
tags: post
---

The other day I needed to test the Mail functionality of an application I was developing on Windows 7 and I realized that the built in SMTP server had been removed.  I initially thought about just installing the free version of SmarterMail and configuring that but I decided to take a look and see what else I could find.  I ran across smtp4dev on CodePlex.  <a href="http://smtp4dev.codeplex.com/">Codeplex Link</a>

smtp4dev captures emails that are sent to localhost on whatever port you configure smtp4dev to listen on.  You can then inspect the formatting and content by choosing an entry in the list and selecting Inspect or View.

<img class="alignnone size-medium wp-image-141" alt="smtp4dev main screen" src="/images/image_4-300x217.png" width="300" height="217" />

Inspect shows a window that lets you see the MIME parts (Source, Headers, Body) and the raw Message Source. View opens the email message in your default email program.

<img class="alignnone size-medium wp-image-151" alt="Message Inspect Window" src="/images/image_16-300x164.png" width="300" height="164" />

smtp4dev even supports SSL/TTL allowing you to specify a certificate to use for the secure connection.

<img class="alignnone size-medium wp-image-161" alt="smtp4dev options" src="/images/image_6-300x272.png" width="300" height="272" />

smtp4dev is an easy to use utility that provides some powerful capabilities that can make integration testing email functionality in your apps easier.
