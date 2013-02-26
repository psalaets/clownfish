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

    def size
      @status_codes_by_url.size
    end

    def empty?
      size == 0
    end

    # Public: Gets url/status code pairs that match one of the specified status
    # codes.
    #
    # status_group_specifiers - One, many or an Array of status group specifiers
    #                           as accepted by StatusGroup.new.
    #
    # Returns url/status pairs that match status specifiers.
    def query(*status_group_specifiers)
      group = StatusGroup.new(status_group_specifiers)

      @status_codes_by_url.find_all { |url, code| group.include? code }
    end
  end
end