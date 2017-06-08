
# UBUNTU: 7.4.2, 7.4.3
# CENTOS6: 5.5.2, 5.5.3
describe file('/etc/hosts.allow') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_file }
  its('mode') { should cmp '0644' }
end

# UBUNTU: 7.4.4, 7.4.5
# CENTOS6: 5.5.4, 5.5.5
describe file('/etc/hosts.deny') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_file }
  its('mode') { should cmp '0644' }
end
describe file('/etc/hosts.deny') do
  its('content') { should match /ALL: ALL/ }
end
