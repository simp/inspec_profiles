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

control "V-72145" do
  title "The operating system must generate audit records for all unsuccessful 
account access events."
  desc  "
    Without generating audit records that are specific to the security and mission 
needs of the organization, it would be difficult to establish, correlate, and 
investigate the events relating to an incident or identify those responsible for one.
    
    Audit records can be generated from various components within the information 
system (e.g., module or policy filter).
    
    Satisfies: SRG-OS-000392-GPOS-00172, SRG-OS-000470-GPOS-00214, 
SRG-OS-000473-GPOS-0021.
  "
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000392-GPOS-00172"
  tag "gid": "V-72145"
  tag "rid": "SV-86769r2_rule"
  tag "stig_id": "RHEL-07-030610"
  tag "cci": "CCI-000126"
  tag "nist": ["AU-2 d", "Rev_4"]
  tag "cci": "CCI-000172"
  tag "nist": ["AU-12 c", "Rev_4"]
  tag "cci": "CCI-002884"
  tag "nist": ["MA-4 (1) (a)", "Rev_4"]
  tag "check": "Verify the operating system generates audit records when 
unsuccessful account access events occur. 

Check the file system rule in \"/etc/audit/audit.rules\" with the following 
commands: 

# grep -i /var/run/faillock /etc/audit/audit.rules

-w /var/run/faillock -p wa -k logins

If the command does not return any output, this is a finding."
  tag "fix": "Configure the operating system to generate audit records when 
unsuccessful account access events occur. 

Add or update the following rule in \"/etc/audit/rules.d/audit.rules\": 

-w /var/run/faillock/ -p wa -k logins

The audit daemon must be restarted for the changes to take effect."
end
