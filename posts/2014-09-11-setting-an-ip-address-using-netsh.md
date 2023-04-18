---
title: Setting an IP address using netsh instead of arp -s on Windows 8.1
date: 2014-09-11T23:39:00 -4:00
author: gabrewer
comments: true
categories: [Hardware]
tags: post
---

I recently had to setup many Epson TM-T88V receipt printers for a POS installation and out of the box they are configured with a static address of 192.168.192.168.  Pressing the reset button for 3 seconds prints out the status of the printer including the MAC address so I though I would just use arp –s to configure the printers but I received an error.  So after a some googling with Bing I turned up this article that pointed me to the the fact that you need to use netsh with recent versions of Windows.

First you need to get the name of the interface that the device is connected to.  Then you execute the netsh interface ipv4 add neighbors command.

<pre class="highlight prettyprint">netsh interface ipv4 show interfaces

Idx     Met         MTU          State                Name
---  ----------  ----------  ------------  ---------------------------
  3          10        1500  connected     Ethernet
  1          50  4294967295  connected     Loopback Pseudo-Interface 1
 63          10        1400  connected     vowire hosting
 10           5        1500  connected     vEthernet (Internal Ethernet Port Windows Phone Emulator Internal Switch)
 29          10        1500  connected     vEthernet (VirtualBox Host-Only Ethernet Adapter Virtual Switch)

netsh interface ipv4 add neighbors "Ethernet" 10.1.10.45 xx-xx-xx-xx-xx-xx

</pre>
