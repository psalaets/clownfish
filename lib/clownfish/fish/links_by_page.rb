module Clownfish
  # Clownfish that records every link on a page and the repsonse status codes
  # when the links are followed.
  class LinksByPage
    # Hash of url String to UrlStatuses.  The values are all links found on page
    # at the key.
    attr_reader :links_by_page

    def initialize
      @links_by_page = {}
    end

    def anemone_options
      # Not looking at page bodies so don't keep them around
      {:discard_page_bodies => true}
    end

    def on_every_page(page)
      # First url in crawl has no page
      referer = page.referer ? page.referer.to_s : '[starting point]'

      @links_by_page[referer] = UrlStatuses.new unless @links_by_page.include? referer

      links = @links_by_page[referer]
      links.add_url(page.url.to_s, page.code)
    end

    # Print links by page to stdout.
    #
    # options - Hash specifying what and how to report.
    #           :to     - IO to print report to.  Defaults to STDOUT.
    #           :status - One or Array of status specifiers. Defaults to :all.
    #                     Only links with these statues will be reported.  See
    #                     Clownfish::StatusGroup for accepted status specifiers.
    def report(options = {})
      options = report_options(options)
      out = options[:to]
      specifiers = options[:status]

      @links_by_page.each do |page, link_statuses|
        link_status_pairs = link_statuses.query(specifiers)

        unless link_status_pairs.empty?
          out.puts "#{page}"
          link_status_pairs.each do |link, status|
            out.puts "#{status} #{link}"
          end
          out.puts
        end
      end
    end

    private

    def report_options(options)
      defaults = {:to => STDOUT, :status => :all}
      defaults.merge(options)
    end
  end
end