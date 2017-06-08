PASS_MAX_DAYS = attribute(
  'pass_max_days',
  default: "60",
  description: "The maximum numbers of days a password is valid"
)

PASS_MIN_DAYS = attribute(
  'pass_min_days',
  default: "7",
  description:"The minimum number of days before you can change your password"
)

PASS_WARN_AGE= attribute(
  'pass_warn_age',
  default: "15",
  description:"The number of days you are notified before you password expires"
)

# CENTOS6: 7.1.1, 7.1.2, 7.1.3
# UBUNTU: 10.1.1, 10.1.2, 10.1.3

describe file('/etc/login.defs') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
end


# These are seperate tests until the reporing bug is worked out
# describe login_defs do
#   its('PASS_MAX_DAYS') { should eq PASS_MAX_DAYS }
#   its('PASS_MIN_DAYS') { should eq PASS_MIN_DAYS }
#   its('PASS_WARN_AGE') { should eq PASS_WARN_AGE }
# end

describe login_defs do
  its('PASS_MAX_DAYS') { should eq PASS_MAX_DAYS }
end

describe login_defs do
  its('PASS_MIN_DAYS') { should eq PASS_MIN_DAYS }
end

describe login_defs do
  its('PASS_WARN_AGE') { should eq PASS_WARN_AGE }
end


# @FIXME This seems to be an oversight in the remediation, left theses tests
# failing so that it would be resolved. The enteries in /etc/shadow also need
# to be remediated as well.
shadow.users(/.*/).entries.each do |entry|
  describe entry do
    its("max_days") { should cmp <= PASS_MAX_DAYS }
  end
end

shadow.users(/.*/).entries.each do |entry|
  describe entry do
    its("min_days") { should cmp >= PASS_MIN_DAYS }
  end
end

shadow.users(/.*/).entries.each do |entry|
  describe entry do
    its("warn_days") { should cmp >= PASS_WARN_AGE }
  end
end
