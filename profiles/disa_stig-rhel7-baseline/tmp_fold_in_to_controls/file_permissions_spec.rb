
# CENTOS6: 6.1.2, 6.1.3, 6.1.4, 6.1.5, 6.1.6, 6.1.7, 6.1.8, 6.1.9, 6.1.10, 9.1.2, 9.1.3, 9.1.4, 9.1.5, 9.1.6, 9.1.7, 9.1.8, 9.1.9
# UBUNTU: 9.1.1, 9.1.2, 9.1.3, 9.1.4, 9.1.5, 9.1.6, 9.1.7, 9.1.8, 12.1, 12.2, 12.3, 12.4, 12.5, 12.6

# CENTOS 9.1.2
# CENTOS 9.1.6
# UBUNTU 12.1
# UBUNTU 12.4
# an example of another approach that can be more readible by security auditors
# it's a bit longer but more in the style of inspec and the intention that we
# would like it readible by non-techies.
describe file('/etc/passwd') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should_not be_executable.by "group" }
  it { should be_readable.by "group" }
  it { should_not be_writable.by "group" }
  it { should_not be_executable.by "other" }
  it { should be_readable.by "other" }
  it { should_not be_writable.by "other" }
  it { should_not be_executable.by "owner" }
  it { should be_readable.by "owner" }
  it { should be_writable.by "owner" }
  its("uid") { should cmp 0 }
  its("gid") { should cmp 0 }
end

# CENTOS 9.1.5
# CENTOS 9.1.9
# UBUNTU 12.6
describe file('/etc/at.allow') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/cron.allow') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/at.deny') do
  it { should_not exist }
end

describe file('/etc/cron.deny') do
  it { should_not exist }
end

describe file('/etc/group') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/anacrontab') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/crontab') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/cron.hourly') do
  it { should exist }
  it { should be_directory }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
describe file('/etc/cron.daily') do
  it { should exist }
  it { should be_directory }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
describe file('/etc/cron.weekly') do
  it { should exist }
  it { should be_directory }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
describe file('/etc/cron.monthly') do
  it { should exist }
  it { should be_directory }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
describe file('/etc/cron.d') do
  it { should exist }
  it { should be_directory }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

# CENTOS6: 6.1.2
describe service('crond') do
  it { should be_enabled }
  it { should be_installed }
  it { should be_running }
end

# CENTOS: 6.1.4
describe command('stat -L -c "%a %u %g" /etc/crontab | egrep ".00 0 0"') do
  its(:stdout) { should match /600 0 0/ }
end

# CENTOS 6.1.10
describe file('/etc/at.deny') do
  it { should_not be_file }
end
describe command('stat -L -c "%a %u %g" /etc/at.allow | egrep ".00 0 0"') do
  its(:stdout) { should match /600 0 0/ }
end

# CENTOS 9.1.4
# CENTOS 9.1.8
describe file('/etc/gshadow') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0000' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

# CENTOS 9.1.7
describe file('/etc/shadow') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0000' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

# CENTOS: 6.1.3
# UBUNTU 9.1.2
describe command('stat -L -c "%a %u %g" /etc/anacrontab | egrep ".00 0 0"') do
  its(:stdout) { should match /600 0 0/ }
end

# CENTOS 6.1.5
# UBUNTU 9.1.3
describe command('stat -c "%a %u %g" /etc/cron.hourly | egrep ".00 0 0"') do
  its(:stdout) { should match /600 0 0/ }
end

# CENTOS 6.1.6
# UBUNTU 9.1.4
describe command('stat -c "%a %u %g" /etc/cron.daily | egrep ".00 0 0"') do
  its(:stdout) { should match /600 0 0/ }
end

# CENTOS 6.1.7
# UBUNTU 9.1.5
describe command('stat -L -c "%a %u %g" /etc/cron.weekly | egrep ".00 0 0"') do
  its(:stdout) { should match /600 0 0/ }
end

# CENTOS 6.1.8
# UBUNTU 9.1.6
describe command('stat -L -c "%a %u %g" /etc/cron.monthly | egrep ".00 0 0"') do
  its(:stdout) { should match /600 0 0/ }
end

# CENTOS 6.1.9
# UBUNTU 9.1.7
describe command('stat -L -c "%a %u %g" /etc/cron.d | egrep ".00 0 0"') do
  its(:stdout) { should match /600 0 0/ }
end
