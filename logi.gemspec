# -*- encoding: utf-8 -*-
# stub: logi 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "logi"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lin Jen-Shin (godfat)"]
  s.date = "2013-09-20"
  s.description = "Highly customizable static blog/wiki generator."
  s.email = ["godfat (XD) godfat.org"]
  s.executables = [
  "logi",
  "logi-list",
  "logi-post",
  "logi-wiki"]
  s.files = [
  ".gitignore",
  ".gitmodules",
  "CHANGES.md",
  "Gemfile",
  "LICENSE",
  "README.md",
  "Rakefile",
  "TODO.md",
  "bin/logi",
  "bin/logi-list",
  "bin/logi-post",
  "bin/logi-wiki",
  "example/config/logi.rb",
  "example/layout/another.html.erb",
  "example/layout/default.html.erb",
  "example/layout/list.html.erb",
  "example/layout/misc/about.html.erb",
  "example/post/hello.md",
  "example/post/index.md",
  "example/post/misc/about.md",
  "example/public/hello.html",
  "example/public/index.html",
  "example/public/list.html",
  "example/public/misc/about.html",
  "lib/logi.rb",
  "lib/logi/command/list.rb",
  "lib/logi/command/post.rb",
  "lib/logi/command/wiki.rb",
  "lib/logi/compiler.rb",
  "lib/logi/config.rb",
  "lib/logi/default.rb",
  "lib/logi/layout/default.html.erb",
  "lib/logi/layout/empty.html.erb",
  "lib/logi/loader.rb",
  "lib/logi/logger.rb",
  "lib/logi/post.rb",
  "lib/logi/runner.rb",
  "lib/logi/version.rb",
  "logi.gemspec",
  "task/.gitignore",
  "task/gemgem.rb"]
  s.homepage = "https://github.com/godfat/logi"
  s.licenses = ["Apache License 2.0"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.4"
  s.summary = "Highly customizable static blog/wiki generator."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bacon>, [">= 0"])
      s.add_development_dependency(%q<muack>, [">= 0"])
      s.add_development_dependency(%q<tilt>, [">= 0"])
    else
      s.add_dependency(%q<bacon>, [">= 0"])
      s.add_dependency(%q<muack>, [">= 0"])
      s.add_dependency(%q<tilt>, [">= 0"])
    end
  else
    s.add_dependency(%q<bacon>, [">= 0"])
    s.add_dependency(%q<muack>, [">= 0"])
    s.add_dependency(%q<tilt>, [">= 0"])
  end
end
