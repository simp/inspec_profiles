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

control "V-72279" do
  title "There must be no shosts.equiv files on the system."
  desc  "The shosts.equiv files are used to configure host-based authentication for 
the system via SSH. Host-based authentication is not sufficient for preventing 
unauthorized access to the system, as it does not require interactive identification 
and authentication of a connection request, or for the use of two-factor 
authentication."
  impact 0.7
  tag "severity": "high"
  tag "gtitle": "SRG-OS-000480-GPOS-00227"
  tag "gid": "V-72279"
  tag "rid": "SV-86903r1_rule"
  tag "stig_id": "RHEL-07-040550"
  tag "cci": "CCI-000366"
  tag "nist": ["CM-6 b", "Rev_4"]
  tag "check": "Verify there are no \"shosts.equiv\" files on the system.

Check the system for the existence of these files with the following command:

# find / -name shosts.equiv

If any \"shosts.equiv\" files are found on the system, this is a finding."
  tag "fix": "Remove any found \"shosts.equiv\" files from the system.

# rm /[path]/[to]/[file]/shosts.equiv"
end
