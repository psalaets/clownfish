module Clownfish
  # Clownfish that records every link on a page and the repsonse status codes
  # when the links are followed.
  class LinksByPage
    # Hash of url String to UrlStatuses.  The values are all links found on page
    # at the key.
    attr_reader :links_by_referer

    def initialize
      @links_by_referer = {}
    end

    def anemone_options
      # Not looking at page bodies so don't keep them around
      {:discard_page_bodies => true}
    end

    def on_every_page(page)
      # First url in crawl has no referer
      referer = if page.referer.nil?
        '[starting point]'
      else
        page.referer.to_s
      end

      @links_by_referer[referer] = UrlStatuses.new unless @links_by_referer.include? referer

      links = @links_by_referer[referer]
      links.add_url(page.url.to_s, page.code)
    end

    # Print links by page to stdout.
    #
    # options - Hash specifying what and how to report.
    #           :to           - IO to print report to.  Defaults to STDOUT.
    #           :status_codes - One or Array of status code specifiers.
    #                           Defaults to :all.  See Clownfish::StatusGroup
    #                           for accepted status code specifiers.
    def report(options = {})
      options = {
        :to => STDOUT,
        :status_codes => :all
      }.merge(options)

      out = options[:to]
      specifiers = options[:status_codes]

      @links_by_referer.each do |referer, link_statuses|
        link_status_pairs = link_statuses.query(specifiers)

        unless link_status_pairs.empty?
          out.puts "#{referer}"
          link_status_pairs.each do |url, status_code|
            out.puts "#{status_code} #{url}"
          end
          out.puts
        end
      end
    end
  end
end