module Clownfish
  class Adapter
    # Public: Create an Adapter that wraps a clownfish.
    #
    # clownfish - Object that conforms to clownfish spec.
    def initialize(clownfish)
      raise ArgumentError, "clownfish cannot be nil" if clownfish.nil?
      @delegate = clownfish
    end

    def options
      (@delegate.respond_to?(:options) && @delegate.options) || {}
    end

    def hook_into_anemone(anemone)
      anemone.after_crawl do |page_store|
        @delegate.after_crawl(page_store)
      end if @delegate.respond_to?(:after_crawl)

      anemone.on_every_page do |page|
        @delegate.on_every_page(page)
      end if @delegate.respond_to?(:on_every_page)
    end
  end
end