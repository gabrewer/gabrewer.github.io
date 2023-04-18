---
title: ASP.NET Web API replaces WCF Web API
date: 2012-02-26T23:33:00 -4:00
author: gabrewer
comments: true
categories: [ASP.NET, Development, WCF, WEBAPI]
tags: post
---

The new MVC 4 beta was released last Thursday / Friday.  One of the big changes is the moving of the WCF Web API into the ASP.NET MVC code stream.

Get the bits and the initial documentation on the ASP.NET Web API page at <a href="http://www.asp.net/web-api">http://www.asp.net/web-api</a>

The team has provided some initial guidance on migrating from the WCF Web API to ASP.NET Web API on the <a href="http://wcf.codeplex.com/wikipage?title=How%20to%20Migrate%20from%20WCF%20Web%20API%20to%20ASP.NET%20Web%20API" target="_blank">WCF CodePlex site</a>.

ScottGu has an overview on <a href="http://weblogs.asp.net/scottgu/archive/2012/02/19/asp-net-mvc-4-beta.aspx" target="_blank">his blog</a> along with a video of a presentation that he gave at the Belgium and Dutch TechReady events.

Jon Galloway interviewed Brad Wilson about the ASP.NET MVC 4 release.  <a href="http://herdingcode.com/?p=396" target="_blank">Brad Wilson on ASP.NET 4 Beta and ASP.NET Web API</a>

Henrik Nielsen the Principal Architect on the WCF Team has a post on the new <a href="http://blogs.msdn.com/b/henrikn/archive/2012/02/16/httpclient-is-here.aspx" target="_blank">HttpClient</a> for ASP.NET Web API that has been back ported from .NET 4.5.

I plan on migrating my current project using the WCF Web API and ASP.NET MVC 3 to the new ASP.NET Web API and ASP.NET MVC 4 API this week.  After spending a lot of time last week getting Ninject work work with the WCF Web API, it looks like the ASP.NET Web API makes it trivial.  But it was still a good learning experience right?

I am also contemplating moving to the new .NET 4.5 beta when it is released.  It looks like the asynchronous support on C# 5 will be very useful with the new ASP.NET Web API.
