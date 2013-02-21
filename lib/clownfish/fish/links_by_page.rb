module Clownfish
  # Clownfish that records every link on a page and the repsonse status codes
  # when the links are followed.
  class LinksByPage
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
    def report
      @links_by_referer.each do |referer, link_statuses|
        puts "#{referer}\n"
        link_statuses.each do |url, status_code|
          puts "#{status_code} #{url}"
        end
        puts
      end
    end
  end
end