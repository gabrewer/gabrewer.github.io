---
layout: post
title: Unable to open Database Project after upgrading to SQL Server 2012 SP1
date: 2012-12-10 23:52
author: gabrewer
comments: true
categories: [Development, SQL Server, Visual Studio]
---
I recently upgraded SQL Server 2012 on my development machine to SP1.  Once it was installed, my solutions with SQL Server Database Projects complain that the version of SQL Server Data Tools is not compatible with the database runtime components install on this computer.

<a href="http://gabrewer.azurewebsites.net/?attachment_id=461" rel="attachment wp-att-461"><img class="alignnone size-medium wp-image-461" alt="ssdt3" src="http://gabrewer.azurewebsites.net/wp-content/uploads/2013/01/ssdt3-300x253.jpg" width="300" height="253" /></a>

Both the “Learn more…” and “Get the latest version of SQL Server Data Tools…” links do not currently resolve to an active page.

Luckily  I was able to find <a href="http://blog.wharton.com.au/" target="_blank">Mr. Wharty's Ramblings - Everything SQL</a> blog which had the <a href="http://blog.wharton.com.au/2012/11/16/sql-server-2012-sp-1-breaks-sql-server-database-projects/" target="_blank">solution</a>, install the latest version of the <a href="http://msdn.microsoft.com/en-us/jj650015" target="_blank">SQL Server Data Tools – November 2012 update</a> and migrate the database projects.
