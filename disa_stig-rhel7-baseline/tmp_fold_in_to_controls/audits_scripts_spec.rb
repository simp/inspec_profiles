
_0700_files = [
  '/root/.audit/find_suid_system_executables.sh',
  '/root/.audit/find_sgid_system_executables.sh',
  '/root/.audit/path_integrity_check.sh',
  '/root/.audit/rhosts_check.sh',
  '/root/.audit/validate_users_homedirs.sh',
  '/root/.audit/check_duplicate_uid.sh',
  '/root/.audit/check_groups_in_etc_passwd.sh',
  '/root/.audit/check_duplicate_gid.sh',
  '/root/.audit/check_duplicate_groupnames.sh',
]

describe file('/root/.audit') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0600' }
end

_0700_files.each do |file|
  describe file(file) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_executable }
    its('mode') { should cmp '0700' }
  end
end
