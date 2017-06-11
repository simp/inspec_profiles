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

control "V-71925" do
  title "Passwords for new users must be restricted to a 24 hours/1 day minimum 
lifetime."
  desc  "Enforcing a minimum password lifetime helps to prevent repeated password 
changes to defeat the password reuse or history enforcement requirement. If users 
are allowed to immediately and continually change their password, the password could 
be repeatedly changed in a short period of time to defeat the organization's policy 
regarding password reuse."
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000075-GPOS-00043"
  tag "gid": "V-71925"
  tag "rid": "SV-86549r1_rule"
  tag "stig_id": "RHEL-07-010230"
  tag "cci": "CCI-000198"
  tag "nist": ["IA-5 (1) (d)", "Rev_4"]
  tag "check": "Verify the operating system enforces 24 hours/1 day as the minimum 
password lifetime for new user accounts.

Check for the value of \"PASS_MIN_DAYS\" in \"/etc/login.defs\" with the following 
command: 

# grep -i pass_min_days /etc/login.defs
PASS_MIN_DAYS     1

If the \"PASS_MIN_DAYS\" parameter value is not \"1\" or greater, or is commented 
out, this is a finding."
  tag "fix": "Configure the operating system to enforce 24 hours/1 day as the 
minimum password lifetime.

Add the following line in \"/etc/login.defs\" (or modify the line to have the 
required value):

PASS_MIN_DAYS     1"
end
