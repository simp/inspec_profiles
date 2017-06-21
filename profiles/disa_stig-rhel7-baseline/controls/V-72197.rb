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

control "V-72197" do
  title "The operating system must generate audit records for all account creations, 
modifications, disabling, and termination events that affect /etc/passwd."
  desc  "
    Without generating audit records that are specific to the security and mission 
needs of the organization, it would be difficult to establish, correlate, and 
investigate the events relating to an incident or identify those responsible for one.
    
    Audit records can be generated from various components within the information 
system (e.g., module or policy filter).
    
    Satisfies: SRG-OS-000004-GPOS-00004, SRG-OS-000239-GPOS-00089, 
SRG-OS-000240-GPOS-00090, SRG-OS-000241-GPOS-00091, SRG-OS-000303-GPOS-00120, 
SRG-OS-000476-GPOS-0022.
  "
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000004-GPOS-00004"
  tag "gid": "V-72197"
  tag "rid": "SV-86821r3_rule"
  tag "stig_id": "RHEL-07-030870"
  tag "cci": "CCI-000018"
  tag "nist": ["AC-2 (4)", "Rev_4"]
  tag "cci": "CCI-000172"
  tag "nist": ["AU-12 c", "Rev_4"]
  tag "cci": "CCI-001403"
  tag "nist": ["AC-2 (4)", "Rev_4"]
  tag "cci": "CCI-002130"
  tag "nist": ["AC-2 (4)", "Rev_4"]
  tag "check": "Verify the operating system must generate audit records for all 
account creations, modifications, disabling, and termination events that affect 
\"/etc/passwd\".

Check the auditing rules in \"/etc/audit/audit.rules\" with the following command:

# grep /etc/passwd /etc/audit/audit.rules

-w /etc/passwd -p wa -k audit_rules_usergroup_modification

If the command does not return a line, or the line is commented out, this is a 
finding."
  tag "fix": "Configure the operating system to generate audit records for all 
account creations, modifications, disabling, and termination events that affect 
\"/etc/passwd\".

Add or update the following rule \"/etc/audit/rules.d/audit.rules\":

-w /etc/passwd -p wa -k identity

The audit daemon must be restarted for the changes to take effect."
end
