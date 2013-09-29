# Logi[![Build Status](https://secure.travis-ci.org/godfat/logi.png?branch=master)](http://travis-ci.org/godfat/logi)

by Lin Jen-Shin ([godfat](http://godfat.org))

## LINKS:

* [github](https://github.com/godfat/logi)
* [rubygems](https://rubygems.org/gems/logi)
* [rdoc](http://rdoc.info/github/godfat/logi)

## DESCRIPTION:

Highly customizable static blog/wiki generator.

## FEATURES:

* Generate posts via external commands, so you can customize it easily.
* Built-in post/list generator using [tilt][]. Support any tilt format.
* Specify configuration in [config/logi.rb](example/config/logi.rb).
* Basic wiki syntax: `[[wiki]]` or `[[wiki|text]]`.
* Write your own layouts.

[tilt]: https://github.com/rtomayko/tilt

## REQUIREMENTS:

* Ruby 1.9+ (Also tested with JRuby and Rubinius)
* Tilt for built-in post/list generator: `gem install tilt`
* Kramdown for markdown generator: `gem install kramdown`

## INSTALLATION:

If you have Ruby installed, you could simply run:

    gem install logi
    gem install tilt     # If you want to use built-in generators
    gem install kramdown # If you want to use Markdown with tilt

If you need to install Ruby, first you should try the one provided
by your package manager.

For Arch Linux, run:

    sudo pacman -Syu     # Update packages list first
    sudo pacman -S ruby

For Mac OS X, if you have Homebrew installed, run:

    brew update          # Update packages list first
    brew install ruby --with-doc

For Windows, you might want to try [RubyInstaller][].

If your package manager does not yet provide Ruby 2.0,
you could try [ruby-install][] which could compile and
handle Ruby's own dependencies for you.

Or just [grab the source tarball][ruby-download] and install it manually.

[RubyInstaller]: http://rubyinstaller.org/
[ruby-install]: https://github.com/postmodern/ruby-install
[ruby-download]: https://www.ruby-lang.org/en/downloads/

## SYNOPSIS:

You can check the [example blog](example). Or read help:

    $ logi -h
    Usage: logi [OPTIONS] [PATH to logi root]
    logi options:
      -c, --color          Color mode (default)
      -n, --no-color    No color mode
      -V, --verbose      Verbose mode (default)
      -q, --quiet          Quiet mode
      -h, --help        Print this message
      -v, --version     Print the version
    defaults:
        root directory  .
        post directory  post
      layout directory  layout
      output directory  public
          post command  post
           layout file  /path/to/logi/lib/logi/layout/default.html.erb

## Built-in generators

* [logi-post](bin/logi-post)
* [logi-list](bin/logi-list)

## Write your own generators

Suppose you want to use [pandoc][] to generate your post, you could build
a command line tool called `logi-pandoc` which the first argument would
be the path to the original post file, and the second argument to the
path of the layout file. Also, read from `stdin` for post content
preprocessed for the wiki syntax.

So you could think of it like this:

    logi-wiki post.md | logi-pandoc post.md layout.html.erb > post.html

For a more complex generator, you could see [logi-list](bin/logi-list)
which would generate a post listing all the posts.

[pandoc]: http://johnmacfarlane.net/pandoc/

## CONTRIBUTORS:

* Lin Jen-Shin (@godfat)

## LICENSE:

Apache License 2.0

Copyright (c) 2013, Lin Jen-Shin (godfat)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
