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
  end
end