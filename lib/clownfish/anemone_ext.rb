module Anemone
  def self.crawl_with_clownfish(urls, clownfish)
    adapter = Clownfish::Adapter.new(clownfish)
    self.crawl(urls, adapter.options) do |anemone|
      adapter.hook_into_anemone(anemone)
    end
  end
end