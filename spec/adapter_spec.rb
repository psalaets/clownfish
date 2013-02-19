require 'spec_helper'

module Clownfish
  describe Adapter do
    it "doesn't accept nil delegate" do
      expect { Adapter.new(nil) }.to raise_error(ArgumentError)
    end

    it "returns options from delegate" do
      delegate = double('delegate')
      delegate.stub(:options) {{:name => 'bob'}}

      adapter = Adapter.new(delegate)

      adapter.options.should eq({:name => 'bob'})
    end

    it "returns empty options if delegate has none" do
      delegate = double('delegate')
      delegate.stub(:options) {nil}

      adapter = Adapter.new(delegate)

      adapter.options.should eq({})
    end

    it "returns empty options if delegate doesn't support options" do
      # No options method
      delegate = Object.new

      adapter = Adapter.new(delegate)

      adapter.options.should eq({})
    end

  end # end of describe Adapter
end # end of Clownfish module
