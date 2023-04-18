---
title: VisualStudio Code fix for icons not appearing
date: 2015-05-16T23:39:00 -4:00
author: gabrewer
comments: true
categories: Development
tags: post
---

When VisualStudio code was announced I went out and installed it right away on my Mac and Windows machines.  One my home development machine I was unable to see the icons.  I was thinking that it was due to my 4K display and an High DPI issue but it turns out not to be the case.

[![image](/images/image_thumb.png "image")](/images/image.png)

In reading the [Reacting to feedback, common issues, and our first update](https://web.archive.org/web/20160114174126/http://blogs.msdn.com/b/vscode/archive/2015/05/13/reacting-to-feedback-common-issues-and-our-first-update.aspx) post on the Visual Studio Code bug it was due to the svg file extension being associated to something other than image/svg+xml in my case due to [Inkscape](https://web.archive.org/web/20160114174126/https://inkscape.org/en/) it was set to application/svg.

[![image](/images/svg_thumb.png "image")](/images/svg_thumb.png)

Changing the Content Type to image/svg+xml made the icons visible.

[![image](/images/image_thumb1.png "image")](/images/image_thumb1)

There is a FAQ with several fixes and workarounds for Visual Studio Code at [https://code.visualstudio.com/Docs/FAQ](https://web.archive.org/web/20160114174126/https://code.visualstudio.com/Docs/FAQ "https://code.visualstudio.com/Docs/FAQ")
