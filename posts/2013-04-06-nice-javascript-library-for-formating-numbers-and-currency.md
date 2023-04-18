---
title: Nice JavaScript library for formating numbers and currency
date: 2013-04-06T15:56:00 -4:00
author: gabrewer
comments: true
categories: [Development, JavaScript]
tags: post
---

<p>In my continuing effort to really learn JavaScript, I was working on putting together a shopping cart application using JavaScript.&nbsp; One of the things I needed to do was format some of values as currency.&nbsp; </p> <p>So I started looking around at the various techniques to accomplish this and ran across <a href="http://josscrowcroft.github.com/accounting.js/" target="_blank">accounting.js</a> a tiny JavaScript for number, money and currency formatting that seemed to fit the bill nicely.&nbsp; </p> <p>Now I can just do this.</p><pre class="csharpcode">accounting.formatMoney(12345678);    <span class="rem">// $12,345,678.00</span>
</pre><a href="http://josscrowcroft.github.com/accounting.js/">http://josscrowcroft.github.com/accounting.js/</a>
