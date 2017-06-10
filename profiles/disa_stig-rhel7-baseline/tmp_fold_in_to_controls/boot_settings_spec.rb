
# CENTOS6 1.4.2
# CENTOS6 1.4.3
describe file('/etc/selinux/config') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('content') { should include('SELINUX=enforcing') }
  its('content') { should include('SELINUXTYPE=targeted') }
end
describe command('/usr/sbin/getenforce') do
  its(:stdout) { should match /Enforcing/ }
end

# CENTOS6: 1.4.1
# CENTOS6: 1.5.3
describe file('/etc/grub2.cfg') do
  it { should exist }
  it { should be_file }
  it { should be_linked_to '/boot/grub2/grub.cfg' }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('content') { should_not include('selinux=0') }
  its('content') { should_not include('enforcing=0') }
  its('content') { should_not include('password --md5') }
end
describe file('/boot/grub2/grub.cfg') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0600' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
# CENTOS6: 1.5.1
describe file("/boot/grub2/grub.cfg") do
  its("gid") { should cmp 0 }
end
describe file("/boot/grub2/grub.cfg") do
  its("uid") { should cmp 0 }
end
# CENTOS6: 1.5.2
describe command('stat -L -c "%a" /etc/grub2.cfg | egrep ".00"') do
  its(:stdout) { should_not match /^$/ }
end

# CENTOS6 1.4.4
describe package('setroubleshoot') do
  it { should_not be_installed }
end

# CENTOS6 1.4.5
describe package('mcstrans') do
  it { should_not be_installed }
end

# TODO- Bad test - Will not always be running on VirtualBox
# describe command('ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ":" " " | awk "{ print $NF }"') do
#   its(:stdout) { should match /^$|VBoxService/ }
# end
# CENTOS6: 1.4.6
control "CIS-1.4.6_Check_for_Unconfined_Daemons" do
  title "Check for Unconfined Daemons"
  desc  "Daemons that are not defined in SELinux policy will inherit the security
        context of their parent process."
  impact 1.0
  processes("*").entries.each do |entry|
    describe entry do
      its("pid") { should be > 0 }
    end
    describe entry do
      its("command") { should match /.*/ }
    end
    describe entry.label.to_s.split(":")[2] do
      it { should_not cmp "initrc_t" }
    end
  end
end

# CENTOS6: 1.5.5
describe file('/etc/sysconfig/init') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

# CENTOS6: 3.2
describe file('/etc/inittab') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('content') { should_not include('id:3:initdefault:') }
end

# CENTOS6: 5.2.1
describe kernel_parameter('net.ipv4.conf.all.accept_source_route') do
  its(:value) { should eq 0 }
end
describe kernel_parameter('net.ipv4.conf.default.accept_source_route') do
  its(:value) { should eq 0 }
end
# CENTOS6: 5.2.2
describe kernel_parameter('net.ipv4.conf.all.accept_redirects') do
  its(:value) { should eq 0 }
end
describe kernel_parameter('net.ipv4.conf.default.accept_redirects') do
  its(:value) { should eq 0 }
end
# CENTOS6: 5.2.3
describe kernel_parameter('net.ipv4.conf.all.secure_redirects') do
  its(:value) { should eq 0 }
end
describe kernel_parameter('net.ipv4.conf.default.secure_redirects') do
  its(:value) { should eq 0 }
end
