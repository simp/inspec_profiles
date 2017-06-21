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

control "V-72185" do
  title "All uses of the pam_timestamp_check command must be audited."
  desc  "Without generating audit records that are specific to the security and 
mission needs of the organization, it would be difficult to establish, correlate, 
and investigate the events relating to an incident or identify those responsible for 
one."
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000471-GPOS-00215"
  tag "gid": "V-72185"
  tag "rid": "SV-86809r2_rule"
  tag "stig_id": "RHEL-07-030810"
  tag "cci": "CCI-000172"
  tag "nist": ["AU-12 c", "Rev_4"]
  tag "check": "Verify the operating system generates audit records when 
successful/unsuccessful attempts to use the \"pam_timestamp_check\" command occur. 

Check the auditing rules in \"/etc/audit/audit.rules\" with the following command:

# grep -i /sbin/pam_timestamp_check /etc/audit/audit.rules

-a always,exit -F path=/sbin/pam_timestamp_check -F perm=x -F auid>=1000 -F 
auid!=4294967295  -k privileged-pam  

If the command does not return any output, this is a finding."
  tag "fix": "Configure the operating system to generate audit records when 
successful/unsuccessful attempts to use the \"pam_timestamp_check\" command occur. 

Add or update the following rule in \"/etc/audit/rules.d/audit.rules\": 

-a always,exit -F path=/sbin/pam_timestamp_check -F perm=x -F auid>=1000 -F 
auid!=4294967295 -k privileged-pam

The audit daemon must be restarted for the changes to take effect."
end
