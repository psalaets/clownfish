module Clownfish
  # Helper class for pairing urls with status codes.
  class UrlStatuses
    attr_reader :status_codes_by_url

    def initialize
      @status_codes_by_url = {}
    end

    def add_url(url, status_code)
      @status_codes_by_url[url] = status_code
    end

    def each(&block)
      @status_codes_by_url.each(&block)
    end
  end
end