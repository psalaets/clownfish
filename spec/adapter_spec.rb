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

    context "hooking into Anemone" do
      before :each do
        @page_store = Object.new
        @page1, @page2 = Object.new, Object.new

        @anemone = FakeAnemone.new(@page_store, @page1, @page2)
      end

      it "wires up after_crawl when delegate supports it" do
        delegate = double('delegate')
        delegate.should_receive(:after_crawl).with(@page_store).once

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)
      end

      it "ignores after_crawl when not supported" do
        delegate = Object.new

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)
      end

      it "wires up on_every_page when delegate supports it" do
        delegate = double('delegate')
        delegate.should_receive(:on_every_page).with(@page1).once
        delegate.should_receive(:on_every_page).with(@page2).once

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)
      end

      it "ignores on_every_page when not supported" do
        delegate = Object.new

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)
      end

      it "wires up focus_crawl when delegate supports it" do
        delegate = double('delegate')
        delegate.should_receive(:focus_crawl).with(@page1) {['url1']}.once

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)

        @anemone.last_focus_crawl_links.should eq(['url1'])
      end

      it "focuses on no links when delegate doesn't focus on any" do
        delegate = double('delegate')
        delegate.should_receive(:focus_crawl).with(@page1) {nil}

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)

        @anemone.last_focus_crawl_links.should eq([])
      end
    end # end of hooking into Anemone
  end # end of describe Adapter
end # end of Clownfish module
