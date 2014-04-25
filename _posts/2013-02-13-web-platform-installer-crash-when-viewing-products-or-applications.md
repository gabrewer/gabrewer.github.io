---
layout: post
title: Web Platform Installer crash when viewing Products or Applications
date: 2013-02-13 00:57
author: gabrewer
comments: true
categories: [Development, IIS, WordPress]
---
<p>Today when I was trying to setup WordPress on my Windows 8 development machine the IIS Manager would crash with an System.OutOfMemoryException exception.</p> <div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; border-top: silver 1px solid; font-family: 'Courier New', courier, monospace; border-right: silver 1px solid; border-bottom: silver 1px solid; padding-bottom: 4px; direction: ltr; text-align: left; padding-top: 4px; padding-left: 4px; margin: 20px 0px 10px; border-left: silver 1px solid; line-height: 12pt; padding-right: 4px; max-height: 200px; width: 97.5%; background-color: #f4f4f4"><pre id="codeSnippet" style="border-top-style: none; overflow: visible; font-size: 8pt; border-left-style: none; font-family: 'Courier New', courier, monospace; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; width: 100%; background-color: #f4f4f4">Exception:System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation.<br> ---&gt; System.Reflection.TargetInvocationException: An exception occurred during the operation, making the result invalid.<br>Check InnerException <span style="color: #0000ff">for</span> exception details. ---&gt; System.OutOfMemoryException: Out of memory.</pre><br></div>
<p>After doing a quick Bing search turn up this <a href="http://forums.iis.net/p/1192160/2042796.aspx/1?p=True&amp;t=634963126897202460" target="_blank">article</a> on the IIS.NET Forums and after clicking “Get New Web Platform Components” problem solved.</p>
