
# RHEL6: 1.4.1, 1.4.2
# CENTOS6: 1.3.1, 1.3.2
# UBUNTU: 8.3.1, 8.3.2

describe package('aide') do
  it { should be_installed }
end

# CENTOS6: 1.3.2
if %w(rhel fedora centos).include?(os[:family])
  describe file('/var/lib/aide/aide.db.gz') do
    it { should be_file }
    it { should be_owned_by 'root' }
  end

  describe cron do
    it { should have_entry '0 5 * * * /usr/sbin/aide --check' }
  end
end

# UBUNTU: 8.3.2
if %w(ubuntu debian).include?(os[:family])
  describe cron do
    it { should have_entry '0 5 * * * /usr/bin/aide --check' }
  end
end
