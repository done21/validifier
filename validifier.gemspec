# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{validifier}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jim Hoskins"]
  s.date = %q{2009-01-29}
  s.description = %q{Generate flash embed code that is valid XHTML}
  s.email = %q{jim@done21.com}
  s.extra_rdoc_files = ["lib/validifier.rb", "LICENSE", "README.rdoc"]
  s.files = ["init.rb", "lib/validifier.rb", "LICENSE", "Manifest", "Rakefile", "README.rdoc", "validifier.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/done21/validifier}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Validifier", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{validifier}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Generate flash embed code that is valid XHTML}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
      s.add_runtime_dependency(%q<htmlentities>, [">= 0"])
    else
      s.add_dependency(%q<hpricot>, [">= 0"])
      s.add_dependency(%q<htmlentities>, [">= 0"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0"])
    s.add_dependency(%q<htmlentities>, [">= 0"])
  end
end
