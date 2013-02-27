require 'clownfish'
require 'uri'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

# Matcher for unordered equality Array
RSpec::Matchers.define :have_same_elements_as do |expected|
  match do |actual|
    expected.sort == actual.sort
  end
end

module Clownfish
  # Fake Anemone::Core to help with tests.
  class FakeAnemone
    attr_reader :last_focus_crawl_links
    attr_reader :last_skip_links_like_regexes

    def initialize(page_store, page1, page2)
      @page_store = page_store
      @page1 = page1
      @page2 = page2
    end

    def after_crawl
      yield(@page_store)
    end

    def on_every_page
      yield(@page1)
      yield(@page2)
    end

    def focus_crawl
      @last_focus_crawl_links = yield(@page1)
    end

    def skip_links_like(regexes)
      @last_skip_links_like_regexes = regexes
    end
  end

  # Fake and minimal Anemone::Page to help with tests.
  class FakePage
    attr_reader :url, :referer, :code

    def initialize(url, code = 200, referer = nil)
      @url = urlify(url)
      @referer = urlify(referer)
      @code = code
    end

    def urlify(str)
      return str if str.class == URI || str.nil?

      str = "http://#{str}" unless str.start_with? 'http'
      URI(str)
    end
  end
end