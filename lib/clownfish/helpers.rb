module Clownfish
  # Helper class for pairing a url with a status code.
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

  # One or more response status codes.  StatusGroups are filled with status
  # specifiers to determine what is in the group.
  #
  # Status specifiers can be Integer status codes like 200, 404 or any of the
  # following Symbols:
  #   :all          - any status code
  #   :success      - 2xx
  #   :redirect     - 3xx
  #   :non_error    - 2xx through 3xx
  #   :client_error - 4xx
  #   :server_error - 5xx
  #   :error        - 4xx through 5xx
  class StatusGroup
    ALIASES = {
      :all          => 200..599,
      :success      => 200..299,
      :redirect     => 300..399,
      :non_error    => 200..399,
      :client_error => 400..499,
      :server_error => 500..599,
      :error        => 400..599
    }

    # Public: Create a new group.
    #
    # statuses - One or more status specifiers or an Array of status specifiers.
    def initialize(*specifiers)
      @members = []

      specifiers.flatten.each do |status|
        self << status
      end
    end

    # Public: Add a status specifier to this group.
    #
    # specifier - A status specifier
    #
    # Returns self for chaining purposes.
    def <<(specifier)
      @members << (ALIASES[specifier] || specifier)
      self
    end

    # Public: Tells if this group includes a given status code.
    #
    # status - Integer status code
    #
    # Returns true if status is included, false otherwise.
    def include?(status)
      @members.any? {|m| m === status}
    end
  end
end