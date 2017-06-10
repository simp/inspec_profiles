

# CENTOS/RHEL 6/7 (2.0.0) 1.5.1
describe file('/etc/security/limits.conf') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should include('hard core 0') }
end

describe file('/etc/sysctl.conf') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  its('mode') { should cmp '0644' }
end

# UBUNTU
if %w(debian ubuntu).include?(os['family'])
  # UBUNTU 7.3.3
  describe command('ip addr | grep inet6') do
    its(:stdout) { should match /^$/ }
  end
end

# CENTOS 5.1.1
# UBUNTU 7.1.1
describe kernel_parameter('net.ipv4.ip_forward') do
  its(:value) { should eq 0 }
end

describe kernel_parameter('net.ipv4.conf.all.forwarding') do
  its(:value) { should eq 0 }
end

describe kernel_parameter('fs.suid_dumpable') do
  its(:value) { should cmp(/(0|2)/) }
end

# CENTOS 1.6.3
# UBUNTU 4.3
describe kernel_parameter('kernel.randomize_va_space') do
  its(:value) { should eq 2 }
end

# CENTOS 5.1.2
# UBUNTU 7.1.2
describe kernel_parameter('net.ipv4.conf.default.send_redirects') do
    its(:value) { should eq 0 }
end
describe kernel_parameter('net.ipv4.conf.all.send_redirects') do
  its(:value) { should eq 0 }
end

# CENTOS6 5.2.2
# UBUNTU 7.2.2
describe kernel_parameter('net.ipv4.conf.default.accept_redirects') do
  its(:value) { should eq 0 }
end
describe kernel_parameter('net.ipv4.conf.all.accept_redirects') do
  its(:value) { should eq 0 }
end

# CENTOS6 5.2.3
# UBUNTU 7.2.3
describe kernel_parameter('net.ipv4.conf.default.secure_redirects') do
  its(:value) { should eq 0 }
end
describe kernel_parameter('net.ipv4.conf.all.secure_redirects') do
  its(:value) { should eq 0 }
end

# CENTOS6 5.2.4
# UBUNTU 7.2.4
describe kernel_parameter('net.ipv4.conf.default.log_martians') do
  its(:value) { should eq 1 }
end
describe kernel_parameter('net.ipv4.conf.all.log_martians') do
  its(:value) { should eq 1 }
end

# CENTOS6 5.2.7
# UBUNTU 7.2.7
describe kernel_parameter('net.ipv4.conf.all.rp_filter') do
  its(:value) { should eq 1 }
end
describe kernel_parameter('net.ipv4.conf.default.rp_filter') do
  its(:value) { should eq 1 }
end

# CENTOS6 5.4.1.1
# UBUNTU 7.3.1
describe kernel_parameter('net.ipv6.conf.all.accept_ra') do
  its(:value) { should eq 0 }
end
describe kernel_parameter('net.ipv6.conf.default.accept_ra') do
  its(:value) { should eq 0 }
end

# CENTOS6 5.4.1.2
# UBUNTU 7.3.2
describe kernel_parameter('net.ipv6.conf.default.accept_redirects') do
  its(:value) { should eq 0 }
end
describe kernel_parameter('net.ipv6.conf.all.accept_redirects') do
  its(:value) { should eq 0 }
end
