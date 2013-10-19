# Clownfish

Helper for [Anemone](http://anemone.rubyforge.org/). Makes common crawls easier to repeat.

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

Reference: [Anemone RDocs](http://anemone.rubyforge.org/doc/index.html)

### anemone_options

Returns a `Hash` of `Symbol` to values. See [Anemone::Core::DEFAULT_OPTS](http://git.io/wFmCfA) for available options.
This is forwarded as the second argument to `Anemone.crawl` ([rdoc](http://anemone.rubyforge.org/doc/classes/Anemone/Core.html)). Invoked once before crawl.

### skip_links_like

Returns a single `Regexp` or `Array` of `Regexp`. Urls matching any of these will not be crawled. Invoked once before crawl.

### on_every_page

Takes one argument, an `Anemone::Page` ([rdoc](http://anemone.rubyforge.org/doc/classes/Anemone/Page.html)). Invoked once per page during crawl.

### focus_crawl

Takes one argument, an `Anemone::Page` ([rdoc](http://anemone.rubyforge.org/doc/classes/Anemone/Page.html)). Returns the links (`Array` of `URI`) on that page that should be crawled. See `Anemone::Page#links` for a starting point. Invoked once per page during crawl.

### after_crawl

Takes one argument, an `Anemone::PageStore` ([rdoc](http://anemone.rubyforge.org/doc/classes/Anemone/PageStore.html)). Invoked once after crawl is done.

## What's Included

See [wiki](https://github.com/psalaets/clownfish/wiki) for examples.

### Clownfish::LinksByPage

Lists every page that has links, the links and the status code when following those links.

### Clownfish::ResponseTimes

Record every url and it's response time.

### Clownfish::Count

Count pages.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
