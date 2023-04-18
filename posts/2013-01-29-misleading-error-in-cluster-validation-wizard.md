---
title: Misleading error in Cluster Validation Wizard
date: 2013-01-29T01:26:00 -4:00
author: gabrewer
comments: true
categories: [Clustering, Hardware, Hyper-V]
tags: post
---

<p>This weekend we were migrating a Hyper-V cluster form Windows Server 2008 R2 to Windows Server 2012.&nbsp; Our hosts were HP DL360p Gen 8 servers connected to a HP P2000 G3 MSA iSCSI storage array.&nbsp; </p> <p>After getting our hosts all configured and connected to the SAN we were ready to install the cluster.&nbsp; When we ran the Cluster Validation Wizard we received some warnings.&nbsp; One of warnings seemed quite troubling.&nbsp; </p> <p><font face="Consolas">Test Disk 0 does not support SCSI-3 Persistent Reservations commands needed to support clustered Storage Pools. Some storage devices require specific firmware versions or settings to function properly with failover clusters. Please contact your storage administrator or storage vendor to check the configuration of the storage to allow it to function properly with failover clusters.</font></p> <style type="text/css">.csharpcode, .csharpcode pre
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
</style>   <p>This appears to be a big problem because SCSI-3 Persistent Reservations are very important to the cluster working correctly.&nbsp; </p><!--more--><p>We had been using this same model of array in our Windows Server 2008 R2 clusters so we knew that the P2000 support SCSI-3 Persistent Reservations.&nbsp; So we went off to google it with bing to find the answer to what was happening with the Windows Server 2012 cluster.&nbsp; We found several posts on the HP support forums that had no solutions and found that HP had no VSS or VDS providers for the P2000 for Windows Server 2012 yet.&nbsp; (Which means no hardware snapshots with DPM yet)</p> <p>Then we started to look at the warning more closely.&nbsp; One of things we realized was it was a warning and not an error.&nbsp; It seem like a SCSI-3 Persistent Reservation failure would have been a fatal error to the cluster validation error.&nbsp; Then we realized that there were two SCSI-3 Persistent Test in the Server 2012 Cluster validation tests.&nbsp; One was “Validate SCSI-3 Persistent Reservation” and the other was “Validate Storage Spaces Persistent Reservation”.&nbsp; The first one passed and it was the second one that failed. </p> <p>It turns out that the test that was failing was for the new&nbsp; Windows Server 2012 feature of clustered Storage Spaces which only works on direct connected SATA or SAS JBOD disks, no RAID, iSCSI or Fibre Channel disks will ever pass this test.&nbsp; So we went ahead and created the cluster and everything is working great.</p> <p><a href="http://social.technet.microsoft.com/wiki/contents/articles/11382.storage-spaces-frequently-asked-questions-faq.aspx#What_types_of_storage_arrays_can_I_use_with_Storage_Spaces" target="_blank">From TechNet</a></p> <h4><font face="Consolas">What types of drives can I use with Storage Spaces?</font></h4> <p><font face="Consolas">You can use commodity drives attached via Serial-Attached SCSI (SAS), Serial ATA (SATA), or USB. Storage layers that abstract the physical disks are not compatible with Storage Spaces. This includes VHDs and pass-through disks in a virtual machine, and storage subsystems that layer a RAID implementation on top of the physical disks. iSCSI and Fibre Channel controllers are not supported by Storage Spaces.</font> <p>We did later find one link on <a href="http://serverfault.com/questions/449083/windows-2012-cluster-on-p6300-scsi-3-persistent-reservation-issues" target="_blank">ServerFault</a> that validated our conclusion that the warning was benign.&nbsp; So the warning that seem scary really turn out to be nothing.&nbsp; It seems like the warning message is very misleading as to the root cause of the issue that triggered it.</p>
