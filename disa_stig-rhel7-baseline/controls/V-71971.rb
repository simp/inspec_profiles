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

control "V-71971" do
  title "The operating system must prevent non-privileged users from executing 
privileged functions to include disabling, circumventing, or altering implemented 
security safeguards/countermeasures."
  desc  "
    Preventing non-privileged users from executing privileged functions mitigates 
the risk that unauthorized individuals or processes may gain unnecessary access to 
information or privileges.
    
    Privileged functions include, for example, establishing accounts, performing 
system integrity checks, or administering cryptographic key management activities. 
Non-privileged users are individuals who do not possess appropriate authorizations. 
Circumventing intrusion detection and prevention mechanisms or malicious code 
protection mechanisms are examples of privileged functions that require protection 
from non-privileged users.
  "
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000324-GPOS-00125"
  tag "gid": "V-71971"
  tag "rid": "SV-86595r1_rule"
  tag "stig_id": "RHEL-07-020020"
  tag "cci": "CCI-002165"
  tag "nist": ["AC-3 (4)", "Rev_4"]
  tag "cci": "CCI-002235"
  tag "nist": ["AC-6 (10)", "Rev_4"]
  tag "check": "Verify the operating system prevents non-privileged users from 
executing privileged functions to include disabling, circumventing, or altering 
implemented security safeguards/countermeasures.

Get a list of authorized users (other than System Administrator and guest accounts) 
for the system.

Check the list against the system by using the following command:

# semanage login -l | more
Login Name  SELinux User   MLS/MCS Range  Service
__default__  user_u    s0-s0:c0.c1023   *
root   unconfined_u   s0-s0:c0.c1023   *
system_u  system_u   s0-s0:c0.c1023   *
joe  staff_u   s0-s0:c0.c1023   *

All administrators must be mapped to the \"sysadm_u\" or \"staff_u\" users with the 
appropriate domains (sysadm_t and staff_t).

All authorized non-administrative users must be mapped to the \"user_u\" role or the 
appropriate domain (user_t).

If they are not mapped in this way, this is a finding."
  tag "fix": "Configure the operating system to prevent non-privileged users from 
executing privileged functions to include disabling, circumventing, or altering 
implemented security safeguards/countermeasures.

Use the following command to map a new user to the \"sysdam_u\" role: 

#semanage login -a -s sysadm_u <username>

Use the following command to map an existing user to the \"sysdam_u\" role:

#semanage login -m -s sysadm_u <username>

Use the following command to map a new user to the \"staff_u\" role:

#semanage login -a -s staff_u <username>

Use the following command to map an existing user to the \"staff_u\" role:

#semanage login -m -s staff_u <username>

Use the following command to map a new user to the \"user_u\" role:

# semanage login -a -s user_u <username>

Use the following command to map an existing user to the \"user_u\" role:

# semanage login -m -s user_u <username>"
end
