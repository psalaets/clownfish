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

```
require 'anemone'
require 'clownfish'

clownfish = MyClownfish.new

Anemone.crawl_with_clownfish(start_url, clownfish)

# <query clownfish for data from crawl>
```

## Clownfish Spec

A clownfish is an object that has one or more of the following instance methods:

### options

Returns a Hash of Symbols to values. This is forwarded to the second argument of Anemone.crawl.

### after_crawl

Takes one argument, an Anemone::PageStore. Invoked once after the crawl is done.

### on_every_page

Takes one argument, an Anemone::Page. Invoked once per page.

### focus_crawl

Takes one argument, an Anemone::Page. Returns the links on that page that should be crawled. Invoked once per page.

### skip_links_like

Returns a single Regexp or Array of Regexp's. Urls matching any of these will not be crawled.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
