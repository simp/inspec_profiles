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

control "V-72131" do
  title "All uses of the truncate command must be audited."
  desc  "
    Without generating audit records that are specific to the security and mission
needs of the organization, it would be difficult to establish, correlate, and
investigate the events relating to an incident or identify those responsible for one.

    Audit records can be generated from various components within the information
system (e.g., module or policy filter).

    Satisfies: SRG-OS-000064-GPOS-00033, SRG-OS-000458-GPOS-00203,
SRG-OS-000461-GPOS-00205, SRG-OS-000392-GPOS-0017.
  "
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000064-GPOS-00033"
  tag "gid": "V-72131"
  tag "rid": "SV-86755r2_rule"
  tag "stig_id": "RHEL-07-030540"
  tag "cci": "CCI-000172"
  tag "nist": ["AU-12 c", "Rev_4"]
  tag "cci": "CCI-002884"
  tag "nist": ["MA-4 (1) (a)", "Rev_4"]
  tag "subsystems": ['audit', 'auditd', 'audit_rule']
  tag "check": "Verify the operating system generates audit records when
successful/unsuccessful attempts to use the \"truncate\" command occur.

Check the file system rules in \"/etc/audit/audit.rules\" with the following
commands:

Note: The output lines of the command are duplicated to cover both 32-bit and 64-bit
architectures. Only the lines appropriate for the system architecture must be
present.

# grep -i truncate /etc/audit/audit.rules

-a always,exit -F arch=b32 -S truncate -Fexit=-EPERM -F auid>=1000 -F
auid!=4294967295 -k access

-a always,exit -F arch=b64 -S truncate -F exit=-EACCES -F auid>=1000 -F
auid!=4294967295 -k access

If the command does not return any output, this is a finding."
  tag "fix": "Configure the operating system to generate audit records when
successful/unsuccessful attempts to use the \"truncate\" command occur.

Add or update the following rule in \"/etc/audit/rules.d/audit.rules\" (removing
those that do not match the CPU architecture):

-a always,exit -F arch=b32 -S truncate -F exit=-EPERM -F auid>=1000 -F
auid!=4294967295 -k access

-a always,exit -F arch=b64 -S truncate -F exit=-EACCES -F auid>=1000 -F
auid!=4294967295 -k access

The audit daemon must be restarted for the changes to take effect."

  # Need to figure out a better way to do this.
  libraries = File.join(File.dirname(File.dirname(source)), 'libraries')
  eval(File.read(File.join(libraries, '/profile_helper/audit.rb')))

  check_syscalls('truncate')
end
