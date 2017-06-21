only_if do
  package('audit').installed?
end

describe file('/etc/audit') do
  it { should exist }
  it { should be_directory }
end

describe file('/etc/audit/auditd.conf') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0640' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe auditd_conf do
  its('log_file') { should eq '/var/log/audit/audit.log' }
  its('log_format') { should eq 'RAW' }
  its('log_group') { should eq 'root' }
  its('priority_boost') { should eq '4' }
  its('flush') { should eq 'INCREMENTAL' }
  its('freq') { should eq '20' }
  its('num_logs') { should eq '5' }
  its('disp_qos') { should eq 'lossy' }
  its('dispatcher') { should eq '/sbin/audispd' }
  its('name_format') { should eq 'NONE' }
  its('max_log_file') { should eq '25' }
  its('max_log_file_action') { should eq 'keep_logs' }
  its('space_left') { should eq '75' }
  its('space_left_action') { should eq 'email' }
  its('action_mail_acct') { should eq 'root' }
  its('admin_space_left') { should eq '50' }
  its('admin_space_left_action') { should eq 'halt' }
  its('disk_full_action') { should eq 'SUSPEND' }
  its('disk_error_action') { should eq 'SUSPEND' }
  its('tcp_listen_queue') { should eq '5' }
  its('tcp_max_per_addr') { should eq '1' }
  its('tcp_client_ports') { should eq '1024-65535' }
  its('use_libwrap') { should eq 'yes' }
  its('tcp_client_max_idle') { should eq '0' }
  its('enable_krb5') { should eq 'no' }
  its('krb5_principal') { should eq 'auditd' }
end
