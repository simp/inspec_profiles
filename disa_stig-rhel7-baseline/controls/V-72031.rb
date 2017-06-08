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

control "V-72031" do
  title "Local initialization files for local interactive users must be group-owned 
by the users primary group or root."
  desc  "Local initialization files for interactive users are used to configure the 
user's shell environment upon logon. Malicious modification of these files could 
compromise accounts upon logon."
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-OS-000480-GPOS-00227"
  tag "gid": "V-72031"
  tag "rid": "SV-86655r2_rule"
  tag "stig_id": "RHEL-07-020700"
  tag "cci": "CCI-000366"
  tag "nist": ["CM-6 b", "Rev_4"]
  tag "check": "Verify the local initialization files of all local interactive users 
are group-owned by that user’s primary Group Identifier (GID).

Check the home directory assignment for all non-privileged users on the system with 
the following command:

Note: The example will be for the smithj user, who has a home directory of 
\"/home/smithj\" and a primary group of \"users\".

# cut -d: -f 1,4,6 /etc/passwd | egrep \":[1-4][0-9]{3}\"
smithj:1000:/home/smithj

# grep 1000 /etc/group
users:x:1000:smithj,jonesj,jacksons 

Note: This may miss interactive users that have been assigned a privileged User 
Identifier (UID). Evidence of interactive use may be obtained from a number of log 
files containing system logon information.

Check the group owner of all local interactive users’ initialization files with the 
following command:

# ls -al /home/smithj/.*
-rwxr-xr-x  1 smithj users        896 Mar 10  2011 .profile
-rwxr-xr-x  1 smithj users        497 Jan  6  2007 .login
-rwxr-xr-x  1 smithj users        886 Jan  6  2007 .something

If all local interactive users’ initialization files are not group-owned by that 
user’s primary GID, this is a finding."
  tag "fix": "Change the group owner of a local interactive user’s files to the 
group found in \"/etc/passwd\" for the user. To change the group owner of a local 
interactive user home directory, use the following command:

Note: The example will be for the user smithj, who has a home directory of 
\"/home/smithj\", and has a primary group of users.

# chgrp users /home/smithj/<file>"
end
