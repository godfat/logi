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
* Basic wiki syntax: [[wiki]] or [[wiki|text]].
* Write your own layouts.

[tilt]: https://github.com/rtomayko/tilt

## REQUIREMENTS:

* Tested with MRI (official CRuby) 2.0.0, Rubinius and JRuby.
* Tilt for built-in post/list generator: `gem install tilt`

## INSTALLATION:

    gem install logi

## SYNOPSIS:

You can check the [example blog](example). Or read help:

    $ logi -h
    Usage: logi \[OPTIONS\] \[PATH to logi root\]
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
path of the layout file. Also, read from stdin for post content
preprocessed for the wiki syntax.

So you could think of it like this:

    logi-wiki post.md | logi-pandoc post.md layout.html.erb > post.html

For a more complex generator, you could see [logi-list](bin/logi-list).

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
