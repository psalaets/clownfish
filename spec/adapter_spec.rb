require 'spec_helper'

module Clownfish
  describe Adapter do
    it "doesn't accept nil delegate" do
      expect { Adapter.new(nil) }.to raise_error(ArgumentError)
    end
  end
end