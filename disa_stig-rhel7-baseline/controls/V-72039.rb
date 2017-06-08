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

control "V-72039" do
  title "All system device files must be correctly labeled to prevent unauthorized 
modification."
  desc  "If an unauthorized or modified device is allowed to exist on the system, 
there is the possibility the system may perform unintended or unauthorized 
operations."
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000480-GPOS-00227"
  tag "gid": "V-72039"
  tag "rid": "SV-86663r1_rule"
  tag "stig_id": "RHEL-07-020900"
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
  tag "check": "Verify that all system device files are correctly labeled to prevent 
unauthorized modification.

List all device files on the system that are incorrectly labeled with the following 
commands:

Note: Device files are normally found under \"/dev\", but applications may place 
device files in other directories and may necessitate a search of the entire system.

#find /dev -context *:device_t:* \\( -type c -o -type b \\) -printf \"%p %Z\
\"

#find /dev -context *:unlabeled_t:* \\( -type c -o -type b \\) -printf \"%p %Z\
\"

Note: There are device files, such as \"/dev/vmci\", that are used when the 
operating system is a host virtual machine. They will not be owned by a user on the 
system and require the \"device_t\" label to operate. These device files are not a 
finding.

If there is output from either of these commands, other than already noted, this is 
a finding."
  tag "fix": "Run the following command to determine which package owns the device 
file:

# rpm -qf <filename>

The package can be reinstalled from a yum repository using the command:

# sudo yum reinstall <packagename>

Alternatively, the package can be reinstalled from trusted media using the command:

# sudo rpm -Uvh <packagename>"
end
