---
title: Display Collection+JSON in the browser
date: 2014-11-18T23:39:00 -4:00
author: gabrewer
comments: true
categories: Development
tags: post
---

In the last year I have become enamored with Hypermedia APIs and the Collection+JSON API in particular that I first came across in [Mike Amundsen’s](https://web.archive.org/web/20150504224635/http://www.amundsen.com/) book [Building Hypermedia APIs with HTML5 and Node](https://web.archive.org/web/20150504224635/http://www.amazon.com/gp/product/1449306578/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=1449306578&linkCode=as2&tag=gabrewercom-20&linkId=KMQMXVBUV5L3CBI5)![](https://web.archive.org/web/20150504224635im_/http://ir-na.amazon-adsystem.com/e/ir?t=gabrewercom-20&l=as2&o=1&a=1449306578).  It seems to be a perfect fit for many of the APIs that I have been working on.  Glenn Block created the [CollectionJson.Net](https://web.archive.org/web/20150504224635/https://github.com/WebApiContrib/CollectionJson.Net) library to make it easy to create Collection+JSON based ASP.NET Web APIs.

However when I browse to a WebAPI endpoint that returns a Collection+JSON result in Internet Explorer or Firefox I get a prompt to download the file.

[![image](/images/collectionjson_thumb1.png "image")](collectionjson_thumb1.png)

[![image](/images/collectionjson_thumb2.png "image")](/images/collectionjson_thumb2.png)

Chrome displays the raw JSON result in a more friendly manner.

[![image](/images/image_thumb2.png "image")](/images/image_thumb2.png)

<span id="more-1201"></span>

Although Fiddler or the browser debug tools make it fairly easy to see the results as JSON sometimes it is convenient to see the results rendered directly in the browser.

I found an [old post](https://web.archive.org/web/20150504224635/http://weblog.west-wind.com/posts/2011/Apr/01/Displaying-JSON-in-your-Browser) from Rick Strahl’s blog regarding how to display application/json.  He suggests using JSONView for Firefox and adding a registry entry for Internet Explorer.  I was able to easily tweak the Internet Explorer registry keys to handle vnd.collection+json.  Unfortunately JSONView for Firefox will not work for the application/vnd.collection+json media type. [https://github.com/bhollis/jsonview/issues/7](https://web.archive.org/web/20150504224635/https://github.com/bhollis/jsonview/issues/7 "https://github.com/bhollis/jsonview/issues/7")

For internet Explorer it is just a matter of changing the Content type entered in the registry from application/json to application/vnd.collection+json

Create a new application/vnd.collection+json key in:

- HKEY_CLASSES_ROOT\MIME\Database\ContentType\*\*application/vnd.collection+json\*\*
- Add a string value of CLSID with a value of {25336920-03F9-11cf-8FD0-00AA00686F13} (the CLSID for the “Browse in place” action)
- Add a DWORD value of Encoding with a hex value of 0x00080000

<pre class="highlight prettyprint">[HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.collection+json]
“CLSID”=”{25336920-03F9-11cf-8FD0-00AA00686F13}”
“Encoding”=hex:08,00,00,00

</pre>

[![image](/images/image_thumb3.png "image")](/images/image3.png)

Now Collection_JSON results will display directly in Internet Explorer.

[![image](/images/image_thumb4.png "image")](/images/image4.png)

For Firefox it was just a matter of specifying the application to open the media type as Firefox.

[![image](/images/image_thumb5.png "image")](/images/image5.png)

This adds the application/vnd.collection+json media type to the Applications list in the Firefox Options dialog.

[![image](/images/image_thumb6.png "image")](/images/image6.png)

And now Collection+JSON results will display directly in the Firefox window.

[![image](/images/image_thumb7.png "image")](/images/image7.png)

This technique will work for other types of +json media types as well such as Mason (application/vnd.mason+json) and HAL (application/vnd.hal+json).
