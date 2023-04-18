---
title: Windows 8 installed on Lenovo W520 - Finally
date: 2012-07-07T23:50:00 -4:00
author: gabrewer
comments: true
categories: [Hardware, Lenovo]
tags: post
---

Well, I finally got around to figuring out why I could not install the Windows 8 Release Preview on my Lenovo ThinkPad W520.  Every time I went to install the OS it would hang during boot.  That issue turned out to be that I needed to install on a <a href="http://support.lenovo.com/en_US/downloads/detail.page?&amp;DocID=HT073269" target="_blank">GPT disk using the UEFI bios</a>.

Before doing that I installed the latest <a href="http://support.lenovo.com/en_US/downloads/detail.page?&amp;DocID=DS029675" target="_blank">bios from the Lenovo site</a>.

After upgrading the Bios and backing up the little data I wanted to save, I proceeded to install the OS.  I went through the boot process fine, installed the installation files reboot and then hung at 90% when configuring devices.  After fiddling with the video driver settings Optimus, Integrated and Discrete, I tired disabling the wireless card and the install completed successfully.

After the installation was complete, I installed the <a href="http://support.lenovo.com/en_US/downloads/detail.page?DocID=HT072084" target="_blank">Lenovo Windows 8 beta drivers</a> turned the wireless adapter back on, crossed my fingers and rebooted and I am finally running Windows 8 on my Lenovo W520!

<img class="alignnone size-medium wp-image-421" alt="lenovowin8_2" src="/images/lenovowin8_2-300x218.png" width="300" height="218" />

Update:  After installing all the Windows 8 drivers there was one unknown device.  Turns out it was the ThinkPad Power Management Device.  I downloaded the <a href="http://support.lenovo.com/en_US/downloads/detail.page?DocID=DS014939" target="_blank">Windows 7 driver</a> from the Lenovo site and everything seems good.
