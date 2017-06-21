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

control "V-72211" do
  title "The rsyslog daemon must not accept log messages from other servers unless 
the server is being used for log aggregation."
  desc  "
    Unintentionally running a rsyslog server accepting remote messages puts the 
system at increased risk. Malicious rsyslog messages sent to the server could 
exploit vulnerabilities in the server software itself, could introduce misleading 
information in to the system's logs, or could fill the system's storage leading to a 
Denial of Service.
    If the system is intended to be a log aggregation server its use must be 
documented with the ISSO.
  "
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000480-GPOS-00227"
  tag "gid": "V-72211"
  tag "rid": "SV-86835r1_rule"
  tag "stig_id": "RHEL-07-031010"
  tag "cci": "CCI-000318"
  tag "nist": ["CM-3 f", "Rev_4"]
  tag "cci": "CCI-000368"
  tag "nist": ["CM-6 c", "Rev_4"]
  tag "cci": "CCI-001812"
  tag "nist": ["CM-11 (2)", "Rev_4"]
  tag "cci": "CCI-001813"
  tag "nist": ["CM-5 (1)", "Rev_4"]
  tag "cci": "CCI-001814"
  tag "nist": ["CM-5 (1)", "Rev_4"]
  tag "check": "Verify that the system is not accepting \"rsyslog\" messages from 
other systems unless it is documented as a log aggregation server.

Check the configuration of \"rsyslog\" with the following command:

# grep imtcp /etc/rsyslog.conf
ModLoad imtcp

If the \"imtcp\" module is being loaded in the \"/etc/rsyslog.conf\" file, ask to 
see the documentation for the system being used for log aggregation.

If the documentation does not exist, or does not specify the server as a log 
aggregation system, this is a finding."
  tag "fix": "Modify the \"/etc/rsyslog.conf\" file to remove the \"ModLoad imtcp\" 
configuration line, or document the system as being used for log aggregation."
end
