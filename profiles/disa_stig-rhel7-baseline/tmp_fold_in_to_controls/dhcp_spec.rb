# CENTOS6: 3.5

describe package('dhcp') do
  it { should_not be_installed }
end

describe service('dhcpd') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end
