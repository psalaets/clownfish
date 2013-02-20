module Clownfish
  # Clownfish that records every link on a page and the repsonse status codes
  # when the links are followed.
  class LinksByPage
    attr_reader :links_by_referer

    def initialize
      @links_by_referer = {}
    end

    def on_every_page(page)
      referer = page.referer.to_s

      # First url in crawl has no referer
      referer = '[starting point]' if referer.empty?

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