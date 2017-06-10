

# CENTOS6: 4.1.3
# UBUNTU: 8.2.3

# This can produce known false positives, new solution coming soon.
describe file('/etc/rsyslog.conf') do
  it { should be_file }
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should include('$FileCreateMode 0640') }
  its('content') { should include('*.emerg :omusrmsg:*') }
  its('content') { should include('mail.* -/var/log/mail') }
  its('content') { should include('mail.info -/var/log/mail.info') }
  its('content') { should include('mail.warning -/var/log/mail.warn') }
  its('content') { should include('mail.err /var/log/mail.err') }
  its('content') { should include('news.crit -/var/log/news/news.crit') }
  its('content') { should include('news.err -/var/log/news/news.err') }
  its('content') { should include('news.notice -/var/log/news/news.notice') }
  its('content') { should include('*.=warning;*.=err -/var/log/warn') }
  its('content') { should include('*.crit /var/log/warn') }
  its('content') { should include('*.*;mail.none;news.none -/var/log/messages') }
  its('content') { should include('local0,local1.* -/var/log/localmessages') }
  its('content') { should include('local2,local3.* -/var/log/localmessages') }
  its('content') { should include('local4,local5.* -/var/log/localmessages') }
  its('content') { should include('local6,local7.* -/var/log/localmessages') }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_installed }
  it { should be_running }
end
