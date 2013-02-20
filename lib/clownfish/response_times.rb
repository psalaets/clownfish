module Clownfish
  # Clownfish that records the response time of every url.
  class ResponseTimes
    # Hash where key is url String and value is number (milliseconds).
    attr_reader :times_by_url

    def initialize
      @times_by_url = {}
    end

    def on_every_page(page)
      @times_by_url[page.url.to_s] = page.response_time
    end
  end
end