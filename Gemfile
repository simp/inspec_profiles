# Variables:
#
# SIMP_GEM_SERVERS | a space/comma delimited list of rubygem servers
gem_sources = ENV.key?('SIMP_GEM_SERVERS') ? ENV['SIMP_GEM_SERVERS'].split(/[, ]+/) : ['https://rubygems.org']

gem_sources.each { |gem_source| source gem_source }

gem 'rake'
gem 'simp-rake-helpers'
gem 'simp-beaker-helpers'
gem 'highline'
gem 'pry'
gem 'kitchen-puppet'
gem 'inspec'
gem 'librarian-puppet'
