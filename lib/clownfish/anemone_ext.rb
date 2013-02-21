require "anemone"

module Anemone
  # Public: Starts an Anemone crawl with a clownfish.
  #
  # urls      - String or Array of Strings telling where to start crawl from.
  # clownfish - Object that conforms to clownfish spec.  See README.md.
  #
  # Returns nothing.
  def self.crawl_with_clownfish(urls, clownfish)
    adapter = Clownfish::Adapter.new(clownfish)
    self.crawl(urls, adapter.anemone_options) do |anemone|
      adapter.hook_into_anemone(anemone)
    end
  end
end