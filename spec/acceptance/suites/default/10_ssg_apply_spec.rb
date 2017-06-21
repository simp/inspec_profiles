require 'spec_helper_acceptance'
require 'json'

test_name 'Remediate via SSG'

# Disclaimer:
#
# This is for something to test the policies against while testing
#
# The remediations in the SSG are almost certainly going to be different from
# those in the SIMP framework since SIMP is built as a composable system and
# not a monolithic 'lockdown'.
#

describe 'Use the SCAP Security Guide to remediate the system' do

  hosts.each do |host|
    os_rel = fact_on(host, 'operatingsystemmajrelease')

    it 'should have the latest SSG build utils installed' do
      host.install_package('git')
      host.install_package('cmake')
      host.install_package('openscap-utils')
      host.install_package('openscap-python')
      host.install_package('python-lxml')
    end

    it 'should download the latest SSG' do
      on(host, 'git clone https://github.com/OpenSCAP/scap-security-guide.git')
    end

    it 'should build the SSG content' do
      on(host, %(cd scap-security-guide/build; cmake ../; make -j4 centos#{os_rel}-content && cp *ds.xml ~))
    end

    it 'should remediate the system against the SSG' do

      # Were accepting all exit codes here because there have occasionally been
      # failures in the SSG content and we're not testing that.

      on(host, %(oscap xccdf eval --remediate --profile xccdf_org.ssgproject.content_profile_stig-rhel#{os_rel}-disa --results scan-xccdf-stig-results.xml ssg-centos#{os_rel}-ds.xml), :accept_all_exit_codes => true)

    end
  end
end
