# dlc-documentation
Repo for creating initial drafts of public documentation for the DLC tool


# Notes

1. React can support KaTex with [remark-math](https://github.com/remarkjs/remark-math) & [rehype-katex](https://github.com/rehypejs/rehype).


# Jekyll

Jekyll seems like it will be a great way to use md files to create documentation.

MacOS instal [here](https://jekyllrb.com/docs/installation/macos/).


# Creating The Initial Site

Github tutorial starts [here](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll).  All of the commands are listed there, except for the following one for the error below [here](#couldnt-run-locally-at-first).

## Github Pages themes

Needed to run `gem install github-pages` for the themes to work locally too.

## Better example

A better example, one I used to create the starting template, was found [here](https://github.com/laredo/mm-jekyll)

### File order in the different sections

Under `_theory` & `_documentation` there are files with numeric prefixes.  This will order them so the default "next" and "previous" buttons generated will be in a desired order.


## Couldn't run locally at first:

Error output (first line is command to serve the site locally):

```
bundle exec jekyll serve
Configuration file: /Users/gp/github/sandia-dlc/dlc-documentation/docs/_config.yml
To use retry middleware with Faraday v2.0+, install `faraday-retry` gem
            Source: /Users/gp/github/sandia-dlc/dlc-documentation/docs
       Destination: /Users/gp/github/sandia-dlc/dlc-documentation/docs/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
       Jekyll Feed: Generating feed for posts
                    done in 0.224 seconds.
 Auto-regeneration: enabled for '/Users/gp/github/sandia-dlc/dlc-documentation/docs'
bundler: failed to load command: jekyll (/Users/gp/.gem/ruby/3.1.3/bin/jekyll)
/Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve/servlet.rb:3:in `require': cannot load such file -- webrick (LoadError)
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve/servlet.rb:3:in `<top (required)>'
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve.rb:184:in `require_relative'
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve.rb:184:in `setup'
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve.rb:102:in `process'
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve.rb:93:in `block in start'
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve.rb:93:in `each'
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve.rb:93:in `start'
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/lib/jekyll/commands/serve.rb:75:in `block (2 levels) in init_with_program'
	from /Users/gp/.gem/ruby/3.1.3/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `block in execute'
	from /Users/gp/.gem/ruby/3.1.3/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `each'
	from /Users/gp/.gem/ruby/3.1.3/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `execute'
	from /Users/gp/.gem/ruby/3.1.3/gems/mercenary-0.3.6/lib/mercenary/program.rb:42:in `go'
	from /Users/gp/.gem/ruby/3.1.3/gems/mercenary-0.3.6/lib/mercenary.rb:19:in `program'
	from /Users/gp/.gem/ruby/3.1.3/gems/jekyll-3.9.3/exe/jekyll:15:in `<top (required)>'
	from /Users/gp/.gem/ruby/3.1.3/bin/jekyll:25:in `load'
	from /Users/gp/.gem/ruby/3.1.3/bin/jekyll:25:in `<top (required)>'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/cli/exec.rb:58:in `load'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/cli/exec.rb:58:in `kernel_load'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/cli/exec.rb:23:in `run'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/cli.rb:486:in `exec'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/vendor/thor/lib/thor/command.rb:27:in `run'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/vendor/thor/lib/thor/invocation.rb:127:in `invoke_command'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/vendor/thor/lib/thor.rb:392:in `dispatch'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/cli.rb:31:in `dispatch'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/vendor/thor/lib/thor/base.rb:485:in `start'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/cli.rb:25:in `start'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/gems/3.1.0/gems/bundler-2.3.26/libexec/bundle:48:in `block in <top (required)>'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/3.1.0/bundler/friendly_errors.rb:120:in `with_friendly_errors'
	from /Users/gp/.rubies/ruby-3.1.3/lib/ruby/gems/3.1.0/gems/bundler-2.3.26/libexec/bundle:36:in `<top (required)>'
	from /Users/gp/.rubies/ruby-3.1.3/bin/bundle:25:in `load'
	from /Users/gp/.rubies/ruby-3.1.3/bin/bundle:25:in `<main>'
```

**Fixed With:**

Apparently ruby 3.0 and greater don't come with `webrick` by default and github pages tutorial doesn't mention it.

`bundle add webrick`

