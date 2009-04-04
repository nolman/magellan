$:.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'config/vendorized_gems'
require 'magellan'
require 'spec/rake/spectask'
require 'magellan/rake/broken_link_task'
require 'magellan/rake/expected_links_task'

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
  t.origin_url = "http://community.thoughtworks.com/"
  t.explore_depth = 20
end

Magellan::Rake::ExpectedLinksTask.new("foo") do |t|
  t.origin_url = "http://www.gap.com/"
  t.explore_depth = 2
  t.patterns_and_expected_links = YAML.load_file("foo.yml")
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "magellan"
    s.summary = "A web testing framework that embraces the exploratory nature of the web"
    s.email = "nolane@gmail.com"
    s.homepage = "http://github.com/nolman/magellan"
    s.description = "TODO"
    s.authors = ["Nolan Evans"]
    s.rubyforge_project = 'magellan'
    s.add_dependency 'mechanize'
    s.add_dependency 'activesupport'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

