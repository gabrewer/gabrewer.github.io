---
title: Node.js, JQuery and Mocha on Windows 8 x64 and PowerShell
date: 2013-02-02T12:54:00 -4:00
author: gabrewer
comments: true
categories: [Development, Node.js, PowerShell]
tags: post
---

<p>Since the <a href="http://pnp.azurewebsites.net/en-us/events.htm" target="_blank">Microsoft Patterns and Practices symposium</a>, I have been wanting to get started learning Node.js.&nbsp; So I added the JumpStart Node.js to my <a href="http://my.safaribooksonline.com/" target="_blank">Safari Books Online</a> bookshelf and installed Node.js from <a title="http://nodejs.org/" href="http://nodejs.org/">http://nodejs.org/</a>.&nbsp; </p> <p>The sample in the first chapter uses a Mongo db provider (MongoLab) but I decided to install mongo locally instead.&nbsp; It installed easily using the <a href="http://docs.mongodb.org/manual/tutorial/install-mongodb-on-windows/" target="_blank">Windows Quick Start</a>.</p> <p>I was on a roll until I got to the next chapter and tried to get the modules installed.&nbsp; The sample uses Mocha for its unit tests.&nbsp; It also uses jQuery.&nbsp; Both proved to be a challenge to get working on my Windows 8 machine.</p> <p>First issue is that Mocha requires a UNIX make command.&nbsp; To get this I installed <a href="http://cygwin.com/" target="_blank">Cygwin</a> with the development tools selected as specified in this <a href="http://stackoverflow.com/questions/9779700/mocha-requires-make-cant-find-a-make-exe-that-works-on-windows" target="_blank">StackOverflow post</a>.&nbsp; I then added the <font size="3" face="Consolas"><strong>Set-Alias make "c:\cygwin\bin\make.exe"</strong></font> to my PowerShell profile.</p> <p>That allowed the <strong><font size="3" face="Consolas">npm install mocha</font></strong> to succeed.</p> <p>My Node.js sample uses jQuery so the next error I ran into was that jQuery install was not succeeding.&nbsp; It failed on the Contextify dependency.&nbsp; After a little goggling with Bing, I found that there are two development tools you need for Node.js development on Windows.&nbsp; Python 2.7 and Visual C++.&nbsp; </p> <p>I had Python 2.7 installed but it wasn’t in the path, so that was a simple fix.&nbsp; If figured that the C++ dependency would be an issue since I do a bunch of C++ development.&nbsp; But when I ran the <font size="3" face="Consolas"><strong>npm install contextify</strong></font>, I received.</p><pre class="csharpcode">error MSB8008: Specified platform toolset (v110) <span class="kwrd">is</span> not installed or invalid.
Please make sure that a supported PlatformToolset <span class="kwrd">value</span> <span class="kwrd">is</span> selected.</pre>
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

<p>So back to StackOverflow and this <a href="http://stackoverflow.com/questions/10280956/how-to-use-msbuild-to-target-v110-platform-toolset" target="_blank">helpful post</a> pointed to the fact that if you have Visual Studio 2012 installed you need to set the <strong><font size="3" face="Consolas">VisualStudioVersion</font></strong> environment variable to 11.0 for MSBuild to pick the correct version.&nbsp; So I added <strong><font size="3" face="Consolas">$env:VisualStudioVersion=”11.0”</font></strong> to my default PowerShell profile and Wallah!&nbsp;&nbsp; <strong><font size="3" face="Consolas">npm install jquery</font></strong> succeeded.</p>
<p>So now I had jQuery, Mocha and Should all installed, so I typed in <font size="3" face="Consolas"><strong>make test</strong></font> hoping for the best and no such luck.</p><pre class="csharpcode">./node_modules/.bin/mocha: line 2: dirname: command not found
./node_modules/.bin/mocha: line 4: uname: command not found

module.js:340
<span class="kwrd">throw</span> err;
^
Error: Cannot find module <span class="str">'C:\mocha\bin\mocha'</span>
at Function.Module.\_resolveFilename (module.js:338:15)
at Function.Module.\_load (module.js:280:25)
at Module.runMain (module.js:492:10)
at process.startup.processNextTick.process.\_tickCallback (node.js:244:9)
Makefile:2: recipe <span class="kwrd">for</span> target `test' failed
make: \*\*\* [test] Error 1</pre>

<p>It couldn’t find the <strong><font size="3" face="Consolas">dirname</font></strong> and <font size="3" face="Consolas"><strong>uname</strong></font> commands so it was looking in the c:\mocha\bin\mocha directory.&nbsp; At least this was a simple one.&nbsp; Adding cygwin bin to the path corrected the error and my test finally ran!</p>
<p>So to summarize the steps I followed to get Mocha and jQuery working on Windows 8 x64 were.</p>
<ul>
<li>Install <a href="http://cygwin.com/" target="_blank">Cygwin</a> with development tools and add it to the path 
<li>Add <font size="3" face="Consolas"><strong>Set-Alias make "c:\cygwin\bin\make.exe" </strong></font>to my PowerShell profile. 
<li>Install <a href="http://python.org/download/" target="_blank">Python 2.7</a> and add it to the path 
<li>Add <strong><font size="3" face="Consolas">$env:VisualStudioVersion=”11.0” </font></strong>to my PowerShell profile. (If you have Visual Studio 2012 installed)</li></ul>
