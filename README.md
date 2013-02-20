# Clownfish

Helper gem for [Anemone](http://anemone.rubyforge.org/). Aids reusability of Anemone driver code.

## Installation

Add this line to your application's Gemfile:

    gem 'clownfish'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clownfish

## Usage

```ruby
require 'clownfish'

clownfish = MyClownfish.new

Anemone.crawl_with_clownfish(start_url, clownfish)

# query clownfish for data from crawl
```

## Clownfish Spec

A clownfish is an object that has one or more of the following instance methods:

Note: [Anemone RDocs](http://anemone.rubyforge.org/doc/index.html)

### options

Returns a `Hash` of `Symbol` to values. This is forwarded as the second argument to `Anemone.crawl`
 (see [Anemone::Core::DEFAULT_OPTS](http://git.io/LhWCUA)). Invoked once before crawl.

### skip_links_like

Returns a single `Regexp` or `Array` of `Regexp`. Urls matching any of these will not be crawled. Invoked once before crawl.

### on_every_page

Takes one argument, an `Anemone::Page`. Invoked once per page during crawl.

### focus_crawl

Takes one argument, an `Anemone::Page`. Returns the links on that page that should be crawled. Invoked once per page during crawl.

### after_crawl

Takes one argument, an `Anemone::PageStore`. Invoked once after crawl is done.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
