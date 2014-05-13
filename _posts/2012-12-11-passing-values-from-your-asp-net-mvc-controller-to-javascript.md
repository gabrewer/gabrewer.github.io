---
layout: post
title: Passing values from your ASP.NET MVC Controller to Javascript
date: 2012-12-11 00:05
author: gabrewer
comments: true
categories: [ASP.NET, Development, JavaScript, MVC]
---
<p>Inspired by <a href="http://www.johnpapa.net/building-single-page-apps-with-knockout-jquery-and-web-api-ndash-the-story-begins" target="_blank">John Papa’s Single Page Application</a> series on <a href="http://www.pluralsight.com/training" target="_blank">Pluralsight</a>, in my latest project I am making heavy use of the JavaScript MVVM pattern.&nbsp; Since my application isn't a true single page application I found myself in some cases needing use values from my Controller in my JavaScript methods. </p> <p>After doing some research I came across this <a href="http://crazorsharp.blogspot.com/2012/02/passing-variables-from-your-controller.html" target="_blank">post from A. Friedman</a> about <a href="https://github.com/brooklynDev/NGon" target="_blank">Ngon</a> a port he created of the Ruby <a href="https://github.com/gazay/gon" target="_blank">Gon</a> gem.&nbsp; Ngon allows you to add a value to a ViewBag NGon property and then consume it in your JavaScript.</p> <p>To use Ngon I can just add the NGonActionFilterAttribute to my RegisterGlobalFilters</p><pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">void</span> RegisterGlobalFilters(GlobalFilterCollection filters)
{
   filters.Add(<span class="kwrd">new</span> NGonActionFilterAttribute());
   filters.Add(<span class="kwrd">new</span> HandleErrorAttribute());
}</pre>
<style type="text/css">.csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>

<p>So in my controller action I just set the Ngon values. </p><pre class="csharpcode"><span class="kwrd">if</span> (User.Identity.IsAuthenticated)
{
   ViewBag.NGon.UserName = User.Identity.Name;
   ViewBag.NGon.CurrentUserId = WebSecurity.CurrentUserId;
}</pre>
<style type="text/css">.csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>

<p>In my _Layout.cshtml file I added a @using NGon and a @Html.IncludeNGon() to the &lt;head&gt; section.</p><pre class="csharpcode">@<span class="kwrd">using</span> NGon
&lt;!DOCTYPE html&gt;
&lt;html lang=<span class="str">"en"</span>&gt;
    &lt;head&gt;
        &lt;meta charset=<span class="str">"utf-8"</span> /&gt;
        &lt;title&gt;@ViewBag.Title - My ASP.NET MVC Application&lt;/title&gt;
        &lt;link href=<span class="str">"~/favicon.ico"</span> rel=<span class="str">"shortcut icon"</span> type=<span class="str">"image/x-icon"</span> /&gt;
        &lt;meta name=<span class="str">"viewport"</span> content=<span class="str">"width=device-width"</span> /&gt;
        @Html.IncludeNGon()
        @Styles.Render(<span class="str">"~/Content/css"</span>)
        @Scripts.Render(<span class="str">"~/bundles/modernizr"</span>)
    &lt;/head&gt;
    &lt;body&gt;
...</pre>
<style type="text/css">.csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>

<div class="csharpcode">&nbsp;</div>
<p>And then I can just use the ngon object like this in my JavaScript</p><pre class="csharpcode">activate = function (callback) {

   config.currentUserId = ngon.CurrentUserId;
   config.currentUser = function () { <span class="kwrd">return</span> { id: function () { <span class="kwrd">return</span> ngon.CurrentUserId; } }; };

    messenger.publish.viewModelActivated({ canleaveCallback: canLeave });
    getActivityItems(callback);
},</pre>
<style type="text/css">.csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>

<p>Very elegant solution to the problem.&nbsp; Ngon is now available as a <a href="https://nuget.org/packages/NGon" target="_blank">Nuget</a> package. </p>
