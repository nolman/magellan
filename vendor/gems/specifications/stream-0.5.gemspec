# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stream}
  s.version = "0.5"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.autorequire = %q{stream}
  s.bindir = nil
  s.cert_chain = nil
  s.date = %q{2004-05-13}
  s.description = %q{Module Stream defines an interface for external iterators.}
  s.email = %q{hd.at.clr@hduchene.de}
  s.files = ["install.rb", "Rakefile", "README", "lib/generator2stream.rb", "lib/stream.rb", "test/bm.rb", "test/testgenerator.rb", "test/teststream.rb", "examples/examples.rb", "examples/streamtester.rb"]
  s.has_rdoc = true
  s.homepage = %q{rgl.rubyforge.org}
  s.require_paths = ["lib"]
  s.required_ruby_version = nil
  s.rubyforge_project = %q{rgl}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Stream - Extended External Iterators}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = -1

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
