# CHANGES

## logi 0.1.1 -- 2013-09-30

* It would no longer give errors if layout is absent.
  Instead, it would emit a warning and use an empty layout.
* It would now expand the root you're passing.
* All commands would now follow --quiet or --nocolor options.
* JRuby support is fixed. (IO.copy_stream cannot work on non-files
  on JRuby)
* `logi -h` would now print the example site path.
* [logi-list] It would now sort the posts with links.

## logi 0.1.0 -- 2013-09-20

* Birthday!
