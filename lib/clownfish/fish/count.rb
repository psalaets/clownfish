module Clownfish
  # Clownfish that counts number of pages on a site.  Taken from Anemone.
  class Count
    attr_reader :count

    def after_crawl(page_store)
      @count = page_store.uniq!.size
    end
  end
end