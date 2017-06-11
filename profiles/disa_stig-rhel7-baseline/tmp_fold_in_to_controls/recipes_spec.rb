# https://github.com/rspec/rspec-expectations/blob/master/Should.md
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect] # default, enables both `should` and `expect`
  end
end
