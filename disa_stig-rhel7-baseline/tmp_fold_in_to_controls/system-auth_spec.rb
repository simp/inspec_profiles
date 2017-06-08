PAM_LINES= attribute(
  'pam_lines',
  default:[
    %r{^auth\s+required\s+pam_env.so},
    %r{^auth\s+required\s+pam_faillock.so\spreauth\saudit\ssilent\sdeny=5\sunlock_time=900},
    %r{^auth\s+sufficient\s+pam_unix.so\snullok\stry_first_pass},
    %r{^auth\s+sufficient\s+pam_faillock.so\sauthsucc\saudit\sdeny=5\sunlock_time=900},
    %r{^auth\s+requisite\s+pam_succeed_if.so\suid\s>=\s1000\squiet_success},
    %r{^auth\s+required\s+pam_deny.so},
    %r{^auth\s+\[success=1\sdefault=bad\]\spam_unix.so},
    %r{^auth\s+\[default=die\]\spam_faillock.so\sauthfail\saudit\sdeny=5\sunlock_time=900},
    %r{^account\s+required\s+pam_unix.so},
    %r{^account\s+sufficient\s+\s+pam_localuser.so},
    %r{^account\s+sufficient\s+\s+pam_succeed_if.so\suid\s<\s1000\squiet},
    %r{^account\s+required\s+pam_permit.so},
    %r{^password\s+\s+requisite\s+pam_pwquality.so\stry_first_pass\slocal_users_only\sretry=3\sauthtok_type=},
    %r{^password\s+\s+sufficient\s+\s+pam_unix.so\ssha512\sshadow\snullok\stry_first_pass\suse_authtok\sremember=5},
    %r{^password\s+\s+required\s+pam_deny.so},
    %r{^session\s+optional\s+pam_keyinit.so\srevoke},
    %r{^session\s+required\s+pam_limits.so},
    %r{^-session\s+optional\s+pam_systemd.so},
    %r{^session\s+\[success=1\sdefault=ignore\]\spam_succeed_if.so\sservice\sin\scrond\squiet\suse_uid},
    %r{^session\s+required\s+pam_unix.so}
  ],
  description: "The lines in the pam.d configuration that you want to validate are set"
  )

# CENTOS6: 6.3.4
# UBUNTU: 9.2.3
# This can produce false positives, new solution coming soon.
describe file('/etc/pam.d/password-auth-ac') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
end

PAM_LINES.each do |line|
  describe file('/etc/pam.d/password-auth-ac') do
    its('content') { should match line }
  end
end

describe file('/etc/pam.d/password-auth') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
  it { should be_linked_to '/etc/pam.d/password-auth-ac' }
end

PAM_LINES.each do |line|
 describe file('/etc/pam.d/password-auth') do
   its('content') { should match line }
 end
end
