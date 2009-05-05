$:.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'config/vendorized_gems'
require 'magellan'
require 'spec/rake/spectask'
require 'magellan/rake/broken_link_task'
require 'magellan/rake/expected_links_task'

task :default => [:spec]

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
  t.origin_url = "http://www.blurb.com/"
  t.explore_depth = 3
  t.failure_log = "log.txt"
end

Magellan::Rake::ExpectedLinksTask.new("gap") do |t|
  t.origin_url = "http://www.gap.com/"
  t.explore_depth = 2
  t.patterns_and_expected_links = YAML.load_file("gap.yml")
  t.ignored_urls = ["http://www.gap.com/customerService/info.do?cid=2019"]
end

Magellan::Rake::ExpectedLinksTask.new("digg") do |t|
  t.origin_url = "http://digg.com/"
  t.explore_depth = 2
  t.patterns_and_expected_links = YAML.load_file("digg.yml")
  t.ignored_urls = ["http://digg.com/slices/topTenList/all"]
end

Magellan::Rake::ExpectedLinksTask.new("blurb") do |t|
  t.origin_url = "http://www.blurb.com/"
  t.explore_depth = 3
  t.patterns_and_expected_links = YAML.load_file("digg.yml")
  t.ignored_urls = []
end


begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "magellan"
    s.summary = "A web testing framework that embraces the discoverable nature of the web"
    s.email = "nolane@gmail.com"
    s.homepage = "http://github.com/nolman/magellan"
    s.description = "TODO"
    s.authors = ["Nolan Evans"]
    s.rubyforge_project = 'magellan'
    s.add_dependency 'mechanize'
    s.add_dependency 'activesupport'
    s.rubyforge_project = 'magellan'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

