$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'spec/rake/spectask'
require 'magellan'
require 'config/vendorized_gems'
require 'magellan/rake/magellan_task'

Spec::Rake::SpecTask.new do |t|
  t.libs << File.join(File.dirname(__FILE__), 'lib')
  t.spec_files = 'spec/**/*_spec.rb'
end

desc "Run all specs with RCov"
Spec::Rake::SpecTask.new(:rcov) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.libs << File.join(File.dirname(__FILE__), 'lib')
  t.rcov = true
  t.rcov_dir = "artifacts/rcov"
  t.rcov_opts << '--text-report'
  t.rcov_opts << '--exclude spec'
end
