module Clownfish
  # Clownfish that records the response time of every url.
  class ResponseTimes
    # Hash where key is url String and value is number (milliseconds).
    attr_reader :times_by_url

    def initialize
      @times_by_url = {}
    end

    def anemone_options
      # Not looking at page bodies so don't keep them around
      {:discard_page_bodies => true}
    end

    def on_every_page(page)
      @times_by_url[page.url.to_s] = page.response_time
    end
  end
end