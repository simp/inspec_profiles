# encoding: utf-8
#
=begin
-----------------
Benchmark: Red Hat Enterprise Linux 7 Security Technical Implementation Guide
Status: Accepted

This Security Technical Implementation Guide is published as a tool to improve
the security of Department of Defense (DoD) information systems. The
requirements are derived from the National Institute of Standards and
Technology (NIST) 800-53 and related documents. Comments or proposed revisions
to this document should be sent via email to the following address:
disa.stig_spt@mail.mil.

Release Date: 2017-03-08
Version: 1
Publisher: DISA
Source: STIG.DOD.MIL
uri: http://iase.disa.mil
-----------------
=end

control "V-71981" do
  title "The operating system must prevent the installation of software, patches,
service packs, device drivers, or operating system components of packages without
verification of the repository metadata."
  desc  "
    Changes to any software components can have significant effects on the overall
security of the operating system. This requirement ensures the software has not been
tampered with and that it has been provided by a trusted vendor.

    Accordingly, patches, service packs, device drivers, or operating system
components must be signed with a certificate recognized and approved by the
organization.

    Verifying the authenticity of the software prior to installation validates the
integrity of the patch or upgrade received from a vendor. This ensures the software
has not been tampered with and that it has been provided by a trusted vendor.
Self-signed certificates are disallowed by this requirement. The operating system
should not have to verify the software again. This requirement does not mandate DoD
certificates for this purpose; however, the certificate used to verify the software
must be from an approved Certificate Authority.
  "
  impact 0.7
  tag "severity": "high"
  tag "gtitle": "SRG-OS-000366-GPOS-00153"
  tag "gid": "V-71981"
  tag "rid": "SV-86605r1_rule"
  tag "stig_id": "RHEL-07-020070"
  tag "cci": "CCI-001749"
  tag "nist": ["CM-5 (3)", "Rev_4"]
  tag "check": "Verify the operating system prevents the installation of patches,
service packs, device drivers, or operating system components of local packages
without verification of the repository metadata.

Check that yum verifies the package metadata prior to install with the following
command:

# grep repo_gpgcheck /etc/yum.conf
repo_gpgcheck=1

If \"repo_gpgcheck\" is not set to \"1\", or if options are missing or commented
out, ask the System Administrator how the metadata of local packages and other
operating system components are verified.

If there is no process to validate the metadata of packages that is approved by the
organization, this is a finding."
  tag "fix": "Configure the operating system to verify the repository metadata by
setting the following options in the \"/etc/yum.conf\" file:

repo_gpgcheck=1"

  yum_conf = file('/etc/yum.conf')

  describe yum_conf.path do
    context yum_conf do
      it { should exist }
    end

    if yum_conf.exist?
      context '[main]' do
        context 'repo_gpgcheck' do
          it { expect( ini(yum_conf.path)['main'][subject] ).to cmp 1 }
        end
      end
    end
  end
end
