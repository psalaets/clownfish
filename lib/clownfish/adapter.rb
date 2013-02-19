module Clownfish
  class Adapter
    # Public: Create an Adapter that wraps a clownfish.
    #
    # clownfish - Object that conforms to clownfish spec.
    def initialize(clownfish)
      raise ArgumentError, "clownfish cannot be nil" if clownfish.nil?
      @deledate = clownfish
    end

    def options
      opts = {}
      opts.merge!(@deledate.options) if @deledate.options
      opts
    end
  end
end