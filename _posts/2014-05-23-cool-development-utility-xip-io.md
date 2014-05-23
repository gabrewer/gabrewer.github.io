---
layout: post
title: Cool Development Utility - xip.io
date: 2014-05-23 17:38
author: gabrewer
comments: true
categories: [Development, Tools]
---

I stumbled across a mention of a free service [xip.io](http://xip.io/) that spared developers the hassle of editing their host file for every new development web site they needed to setup.  Having had to edit the host file many times this really appealed to me.  So I went to find out what type of black magic enabled this.

What I found was a very simple and brilliant solution from [Basecamp](https://basecamp.com) (formally [37signals](http://37signals.com).  xip.io is a public custom dns service that given a [**domain name**].[**ip address**].xip.io returns the **ip address** specified.  

For example 

**www.gabrewer.com.192.168.1.10.xip.io** resolves to **192.168.1.10**  
**dev.gabrewer.com.192.168.1.10.xip.io** resolves to **192.168.1.10**  
**dev.www.gabrewer.com.192.168.1.10.xip.io** returns **192.168.1.10**  

Since this is a hosted service it works for all devices that have an Internet connection including tables, phones and other Internet connected devices.

I always love it when I find a nice piece of engineering that simplifies my development experience.
