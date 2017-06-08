# CENTOS 1.1.18,CENTOS 1.1.19,CENTOS 1.1.20,CENTOS 1.1.21,CENTOS 1.1.22
# CENTOS 1.1.23,CENTOS 1.1.24, CENTOS 5.6.1, CENTOS 5.6.4, CENTOS 5.6.2,
# CENTOS 5.6.3
# UBUNTU 2.18,UBUNTU 2.19,UBUNTU 2.20,UBUNTU 2.21,UBUNTU 2.22,UBUNTU 2.23
# UBUNTU 2.24,UBUNTU 7.5.1, UBUNTU 7.5.4,UBUNTU 7.5.2, UBUNTU 7.5.3
# attributes
BLACKLISTED_MODULES = attribute(
  'blacklisted_modules',
  default: ['cramfs','vfat','cramfs','freevxfs','jffs2','hfs','hfsplus',
    'squashfs','udf'],
  description: "The modules on the system that we wish to blacklist.")

  BLACKLISTED_MODULES_CONF_FILE = attribute(
  'blacklist_conf_file',
  default: '/etc/modprobe.d/CIS.conf',
  description: "The file location of where you keep your blacklisted modules
  configuration file."
  )
# controls
describe file(BLACKLISTED_MODULES_CONF_FILE) do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  its('mode') { should cmp '0644' }
end

BLACKLISTED_MODULES.each do |mod|
  describe kernel_module("#{mod}") do
    it { should_not be_loaded }
  end
end

BLACKLISTED_MODULES.each do |mod|
  describe.one do
    describe command("/sbin/modprobe -n -v #{mod}") do
      its('stdout') { should match /install \/bin\/true/ }
    end
    describe command("/sbin/modprobe -n -v #{mod}") do
      its('stdout') { should match /install \/bin\/false/ }
    end
    describe command('/sbin/modprobe --showconfig | grep blacklist') do
      its('stdout') { should match /#{mod}/ }
    end
  end
end

BLACKLISTED_MODULES.each do |mod|
  describe file(BLACKLISTED_MODULES_CONF_FILE) do
    its('content') { should match /install #{mod} \/bin\/true/}
  end
end
