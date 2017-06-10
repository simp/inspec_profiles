
describe service('avahi-daemon') do
  it { should_not be_enabled }
  it { should_not be_installed }
  it { should_not be_running }
end

describe package('avahi') do
  it { should_not be_installed }
end
