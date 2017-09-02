def check_paths(paths, permissions)
  rules = auditd_rules.rules

  if rules[:syscalls].empty? && rules[:files].empty?
    describe auditd_rules do
      skip 'No matching paths' do
      end
    end
  end

  Array(paths).map(&:strip).each do |path|
    audit_target = file(path)

    describe audit_target do
      if audit_target.exist?
        context File.basename(path) do
          it "should be audited" do
            permission_checks = []

            matching_rules = rules[:files].select{|r| r[:file] == path}

            # We could have more than one match
            matching_rules.each do |rule|
              permission_checks += rule[:permissions].chars
            end

            # This basically just takes all permutations of things that could be
            # stuffed in here and splits them into their component parts for the
            # rspec check
            perms = Array(permissions).flatten.map(&:chars).flatten
            expect(permission_checks).to include(*perms)
          end
        end
      else
        skip "#{path} does not exist" do
        end
      end
    end
  end
end

def check_syscalls(syscalls, architectures=nil)

  rules = auditd_rules.rules[:syscalls]

  arches = Array(architectures)
  if arches.empty?
    arches = ['b32']
    arches << 'b64' if os.arch == 'x86_64'
  end

  describe auditd_rules do
    Array(syscalls).each do |syscall|
      matching_rules = rules.select{|r| r[:syscall] == syscall}

      context syscall do
        arches.each do |arch|
          context arch do
            arch_rules = matching_rules.select{|r| r[:arch] == arch}

            it 'should be audited' do
              arch_rules.each do |rule|
                expect(rule[:action]).to eq('always')
              end
            end
          end
        end
      end
    end
  end
end
