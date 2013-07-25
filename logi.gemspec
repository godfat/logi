# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "logi"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lin Jen-Shin (godfat)"]
  s.date = "2013-07-26"
  s.description = "## FEATURES:"
  s.email = ["godfat (XD) godfat.org"]
  s.executables = ["logi"]
  s.files = [
  ".gitmodules",
  "Gemfile",
  "LICENSE",
  "README.md",
  "Rakefile",
  "bin/logi",
  "example/config/logi.rb",
  "example/layout/index.html.erb",
  "example/post/about.md",
  "lib/logi.rb",
  "lib/logi/runner.rb",
  "lib/logi/version.rb",
  "logi.gemspec",
  "task/.gitignore",
  "task/gemgem.rb"]
  s.homepage = "https://github.com/godfat/logi"
  s.licenses = ["Apache License 2.0"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.5"
  s.summary = "## FEATURES:"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tilt>, [">= 0"])
      s.add_development_dependency(%q<bacon>, [">= 0"])
      s.add_development_dependency(%q<muack>, [">= 0"])
    else
      s.add_dependency(%q<tilt>, [">= 0"])
      s.add_dependency(%q<bacon>, [">= 0"])
      s.add_dependency(%q<muack>, [">= 0"])
    end
  else
    s.add_dependency(%q<tilt>, [">= 0"])
    s.add_dependency(%q<bacon>, [">= 0"])
    s.add_dependency(%q<muack>, [">= 0"])
  end
end
