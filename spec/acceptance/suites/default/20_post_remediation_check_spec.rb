require 'spec_helper_acceptance'
require 'json'

test_name 'Check Inspec'

describe 'run inspec against the appropriate fixtures' do

  profiles_to_validate = ['disa_stig']

  hosts.each do |host|
    profiles_to_validate.each do |profile|
      context "for profile #{profile}" do
        context "on #{host}" do
          before(:all) do
            @inspec = Simp::BeakerHelpers::Inspec.new(host, profile)
          end

          it 'should run inspec' do
            @inspec.run
          end

          it 'should not have any failing tests' do
            inspec_report = @inspec.process_inspec_results

            @inspec.write_report(inspec_report)

            if inspec_report[:failed] > 0
              puts inspec_report[:report]
            end

            expect( inspec_report[:failed] ).to eq(0)
          end
        end
      end
    end
  end
end
