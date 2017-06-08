# encoding: utf-8 
# 
=begin 
----------------- 
Benchmark: Red Hat Enterprise Linux 7 Security Technical Implementation Guide  
Status: Accepted 

This Security Technical Implementation Guide is published as a tool to improve
the security of Department of Defense (DoD) information systems. The
requirements are derived from the National Institute of Standards and
Technology (NIST) 800-53 and related documents. Comments or proposed revisions
to this document should be sent via email to the following address:
disa.stig_spt@mail.mil.

Release Date: 2017-03-08 
Version: 1 
Publisher: DISA 
Source: STIG.DOD.MIL 
uri: http://iase.disa.mil 
----------------- 
=end 

control "V-72305" do
  title "If the Trivial File Transfer Protocol (TFTP) server is required, the TFTP 
daemon must be configured to operate in secure mode."
  desc  "Restricting TFTP to a specific directory prevents remote users from 
copying, transferring, or overwriting system files."
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000480-GPOS-00227"
  tag "gid": "V-72305"
  tag "rid": "SV-86929r1_rule"
  tag "stig_id": "RHEL-07-040720"
  tag "cci": "CCI-000366"
  tag "nist": ["CM-6 b", "Rev_4"]
  tag "check": "Verify the TFTP daemon is configured to operate in secure mode.

Check to see if a TFTP server has been installed with the following commands:

# yum list installed | grep tftp
tftp-0.49-9.el7.x86_64.rpm

If a TFTP server is not installed, this is Not Applicable.

If a TFTP server is installed, check for the server arguments with the following 
command: 

# grep server_arge /etc/xinetd.d/tftp
server_args = -s /var/lib/tftpboot

If the \"server_args\" line does not have a \"-s\" option and a subdirectory is not 
assigned, this is a finding."
  tag "fix": "Configure the TFTP daemon to operate in secure mode by adding the 
following line to \"/etc/xinetd.d/tftp\" (or modify the line to have the required 
value):

server_args = -s /var/lib/tftpboot"
end
