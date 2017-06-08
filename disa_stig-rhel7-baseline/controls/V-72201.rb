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

control "V-72201" do
  title "All uses of the renameat command must be audited."
  desc  "
    If the system is not configured to audit certain activities and write them to an 
audit log, it is more difficult to detect and track system compromises and damages 
incurred during a system compromise.
    
    Satisfies: SRG-OS-000466-GPOS-00210, SRG-OS-000467-GPOS-00210, 
SRG-OS-000468-GPOS-00212, SRG-OS-000392-GPOS-0017.
  "
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000466-GPOS-00210"
  tag "gid": "V-72201"
  tag "rid": "SV-86825r2_rule"
  tag "stig_id": "RHEL-07-030890"
  tag "cci": "CCI-000172"
  tag "nist": ["AU-12 c", "Rev_4"]
  tag "cci": "CCI-002884"
  tag "nist": ["MA-4 (1) (a)", "Rev_4"]
  tag "check": "Verify the operating system generates audit records when 
successful/unsuccessful attempts to use the \"renameat\" command occur.

Check the file system rules in \"/etc/audit/audit.rules\" with the following 
commands:

Note: The output lines of the command are duplicated to cover both 32-bit and 64-bit 
architectures. Only the lines appropriate for the system architecture must be 
present.

# grep -i renameat  /etc/audit/audit.rules
-a always,exit -F arch=b32 -S renameat  -F perm=x -F auid>=1000 -F auid!=4294967295 
-k delete
-a always,exit -F arch=b64 -S renameat  -F perm=x -F auid>=1000 -F auid!=4294967295 
-k delete

If the command does not return any output, this is a finding."
  tag "fix": "Configure the operating system to generate audit records when 
successful/unsuccessful attempts to use the \"renameat\" command occur.

Add the following rules in \"/etc/audit/rules.d/audit.rules\" (removing those that 
do not match the CPU architecture):

-a always,exit -F arch=b32 -S renameat  -F perm=x -F auid>=1000 -F auid!=4294967295 
-k delete
-a always,exit -F arch=b64 -S renameat  -F perm=x -F auid>=1000 -F auid!=4294967295 
-k delete

The audit daemon must be restarted for the changes to take effect."
end
