$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'spec/rake/spectask'
require 'magellan'
require 'config/vendorized_gems'

Spec::Rake::SpecTask.new do |t|
  t.libs << File.join(File.dirname(__FILE__), 'lib')
  t.spec_files = 'spec/**/*_spec.rb'
end