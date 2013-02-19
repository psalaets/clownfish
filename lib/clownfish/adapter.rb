module Clownfish
  # Adapter between Anemone and clownfish objects.
  class Adapter
    # Internal: Create an Adapter that wraps a clownfish.
    #
    # clownfish - Object that conforms to clownfish spec.  See README.md.
    def initialize(clownfish)
      raise ArgumentError, "clownfish cannot be nil" if clownfish.nil?
      @delegate = clownfish
    end

    # Internal: Forwards Anemone options from clownfish.
    #
    # Returns Hash of Anemone options, never nil.
    def options
      (@delegate.respond_to?(:options) && @delegate.options) || {}
    end

    # Internal: Connects clownfish to Anemone.
    #
    # anemone - Instance of Anemone::Core.
    #
    # Returns nothing.
    def hook_into_anemone(anemone)
      wire_up_after_crawl(anemone)
      wire_up_on_every_page(anemone)
      wire_up_focus_crawl(anemone)
      relay_skip_links_like(anemone)
    end

    private

    # Connects delegate's after_crawl to Anemone.
    def wire_up_after_crawl(anemone)
      anemone.after_crawl do |page_store|
        @delegate.after_crawl(page_store)
      end if @delegate.respond_to?(:after_crawl)
    end

    # Connects delegate's on_every_page to Anemone.
    def wire_up_on_every_page(anemone)
      anemone.on_every_page do |page|
        @delegate.on_every_page(page)
      end if @delegate.respond_to?(:on_every_page)
    end

    # Connects delegate's focus_crawl to Anemone.
    def wire_up_focus_crawl(anemone)
      anemone.focus_crawl do |page|
        @delegate.focus_crawl(page) || []
      end if @delegate.respond_to?(:focus_crawl)
    end

    # Passes delegate's skip_links_like to Anemone.
    def relay_skip_links_like(anemone)
      if @delegate.respond_to?(:skip_links_like)
        regexes = @delegate.skip_links_like
        anemone.skip_links_like([regexes].flatten)
      end
    end
  end
end