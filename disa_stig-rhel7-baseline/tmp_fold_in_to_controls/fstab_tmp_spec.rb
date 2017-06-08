
describe file('/dev/shm') do
  it { should be_mounted }
end

describe command('grep /dev/shm /etc/fstab | grep nodev') do
  its(:stdout) { should match /nodev/ }
end

describe mount("/dev/shm") do
  its("options") { should include "nodev" }
end

describe command('grep /dev/shm /etc/fstab | grep nosuid') do
  its(:stdout) { should match /nosuid/ }
end

describe mount("/dev/shm") do
  its("options") { should include "nosuid" }
end

describe command('grep /dev/shm /etc/fstab | grep noexec') do
  its(:stdout) { should match /noexec/ }
end

describe mount("/dev/shm") do
  its("options") { should include "noexec" }
end

describe command('mount | grep /var/tmp') do
  its(:stdout) { should include('/var/tmp') }
end

# TODO: Deal with failing test
describe mount('/var/tmp') do
  it { should be_mounted }
  its('options') { should include 'rw' }
 end

# FIXME: See the note below for the fix to the remediation
#describe file("/etc/fstab") do
#  its("content") { should match /$\s*\/tmp\s+\/var\/tmp\s+none\s+bind\s+0\s+0\s*$/ }
#end
# This should fix your test once you add the chef content to set the right
# fstab entry
#
# % vim /etc/fstab
#/tmp /var/tmp none bind 0 0
#% sudo mount -a
