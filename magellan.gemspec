# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{magellan}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nolan Evans"]
  s.date = %q{2009-04-08}
  s.description = %q{TODO}
  s.email = %q{nolane@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/magellan", "lib/magellan/broken_link_tracker.rb", "lib/magellan/cartographer.rb", "lib/magellan/expected_links_tracker.rb", "lib/magellan/explorer.rb", "lib/magellan/extensions", "lib/magellan/extensions/array.rb", "lib/magellan/extensions/mechanize_page.rb", "lib/magellan/extensions/string.rb", "lib/magellan/logger.rb", "lib/magellan/rake", "lib/magellan/rake/base_magellan_task.rb", "lib/magellan/rake/broken_link_task.rb", "lib/magellan/rake/expected_links_task.rb", "lib/magellan/result.rb", "lib/magellan.rb", "spec/array_spec.rb", "spec/broken_link_task_spec.rb", "spec/broken_link_tracker_spec.rb", "spec/cartographer_spec.rb", "spec/expected_links_task_spec.rb", "spec/expected_links_tracker_spec.rb", "spec/explorer_spec.rb", "spec/logger_spec.rb", "spec/mechanize_page_spec.rb", "spec/result_spec.rb", "spec/spec_helper.rb", "spec/string_extensions_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nolman/magellan}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{magellan}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A web testing framework that embraces the discoverable nature of the web}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mechanize>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
    else
      s.add_dependency(%q<mechanize>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
    end
  else
    s.add_dependency(%q<mechanize>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
  end
end
