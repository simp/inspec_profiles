SSHD_PORT = attribute(
  'sshd_port',
  default: 22,
  description: "The desired port that the sshd server should listen on"
)

SSHD_CONFIG_FILE = attribute(
'sshd_config_file',
default: '/etc/ssh/sshd_config',
description: "The location for your sshd_config file on the filesystem"
)

#@todo !!test me again on the system!!

# CENTOS6: 6.2.2, 6.2.3, 6.2.5, 6.2.6, 6.2.7, 6.2.8, 6.2.9, 6.2.10, 6.2.13, 6.2.14
# UBUNTU: 9.3.1, 9.3.2, 9.3.5, 9.3.3, 9.3.6, 9.3.7, 9.3.8, 9.3.9, 9.3.10, 9.3.13, 9.3.14

only_if do
  package('openssh-server').installed? or command('ssh').exist?
end

control 'sshd-config-1' do
  title "Ensure the proper ownership of the sshd_config file"
  desc "The SSHD_CONFIG file "
  describe file(SSHD_CONFIG_FILE) do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0600' }
  end
end

# The active test below, coming soon :) - to ensure that the config file that the active sshd
# process is using meets the same standards as the passive test above. InSpec
# is looking at how we want to adress this in the resoruces.
#describe sshd_config.config do
#  it { should exist }
#  it { should be_file }
#  it { should be_owned_by 'root' }
#  it { should be_grouped_into 'root' }
#  its('mode') { should cmp '0600' }
#end

control 'sshd-config-2' do
  title "Ensure the proper setting in the sshd_config file"
  desc "Ensure the setting of the sshd_config file are set as expected to meet
        the secuirty standards"
  tag "CENTOS6":['6.2.2','6.2.3','6.2.5','6.2.6','6.2.7','6.2.8','6.2.9','6.2.10','6.2.13','6.2.14']
  tag "UBUNTU":['9.3.1','9.3.2','9.3.5','9.3.3','9.3.6','9.3.7','9.3.8','9.3.9','9.3.10','9.3.13','9.3.14']
  describe sshd_config('/etc/ssh/sshd_config') do
    its('Port') { should cmp SSHD_PORT }
    # CENTOS6: 6.2.2
    # UBUNTU: 9.3.1
    its('Protocol') { should cmp 2 }
    # CENTOS6: 6.2.3
    # UBUNTU: 9.3.2
    its('LogLevel') { should eq 'INFO' }
    # CENTOS: 6.2.5
    # UBUNTU: 9.3.5
    its('MaxAuthTries') { should match /[1-4]/ }
    # CENTOS: 6.2.6
    # UBUNTU: 9.3.6
    its('IgnoreRhosts') { should eq 'yes' }
    # CENTOS: 6.2.7
    # UBUNTU: 9.3.7
    its('HostbasedAuthentication') { should eq 'no' }
    # CENTOS: 6.2.8
    # UBUNTU: 9.3.8
    its('PermitRootLogin') { should eq 'no' }
    # CENTOS: 6.2.9
    # UBUNTU: 9.3.9
    its('PermitEmptyPasswords') { should eq 'no' }
    # CENTOS: 6.2.10
    # UBUNTU: 9.3.10
    its('PermitUserEnvironment') { should eq 'no' }
    # CENTOS: 6.2.13
    # UBUNTU: 9.3.13
    its('DenyUsers') { should cmp('bin,daemon,adm,lp,mail,uucp,operator,games,gopher,ftp,nobody,vcsa,rpc,saslauth,postfix,rpcuser,nfsnobody,sshd') }
    its('content') { should_not include('AllowUsers') }
    its('content') { should_not include('AllowGroups') }
    its('content') { should_not include('DenyGroups') }
    # CENTOS: 6.2.14
    # UBUNTU: 9.3.14
    its('Banner') { should eq '/etc/issue.net' }

    # RHEL6: 6.2.11
    its('Ciphers') { should cmp('aes128-ctr,aes192-ctr,aes256-ctr') }
    its('ChallengeResponseAuthentication') { should eq 'no' }
    its('UsePAM') { should eq 'yes' }
    its('GSSAPIKeyExchange') { should eq 'no' }
    its('GSSAPICleanupCredentials') { should eq 'yes' }
  end
end
