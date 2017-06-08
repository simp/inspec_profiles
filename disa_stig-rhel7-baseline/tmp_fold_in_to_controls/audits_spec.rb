
# CENTOS6: 9.1.10
# UBUNTU: 12.7
describe command("df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002 -print") do
  its(:stdout) { should match /^$/ }
end

# CENTOS6: 9.1.11
# UBUNTU: 12.8
describe command("find / -regex .\\*/.\\* -type f -nouser") do
  its("stdout") { should be_empty }
end

# CENTOS6: 9.1.12
# UBUNTU: 12.9
describe command("find / -regex .\\*/.\\* -type f -nogroup") do
  its("stdout") { should be_empty }
end

# CENTOS6: 9.2.1
# UBUNTU: 13.1
shadow.users(/.*/).entries.each do |entry|
  describe entry do
    its("passwords") { should cmp /.+/ }
  end
end

# CENTOS6: 9.2.2
# UBUNTU: 13.2
describe file("/etc/passwd") do
  its("content") { should_not match /^+:/ }
end

# CENTOS6: 9.2.3
# UBUNTU: 13.3
describe file("/etc/shadow") do
  its("content") { should_not match /^+:/ }
end

# CENTOS6: 9.2.4
# UBUNTU: 13.4
describe file("/etc/group") do
  its("content") { should_not match /^+:/ }
end

# CENTOS6: 9.2.5
# UBUNTU: 13.5
describe file("/etc/passwd") do
  its("content") { should_not match /^(?!root:)[^:]*:[^:]*:0/ }
end
