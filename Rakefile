$:.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'config/vendorized_gems'
require 'magellan'
require 'spec/rake/spectask'
require 'magellan/rake/broken_link_task'

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

Magellan::Rake::BrokenLinkTask.new do |t|
  t.origin_url = "http://digg.com"
  t.explore_depth = 3
end
