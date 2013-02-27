require 'spec_helper'

module Clownfish
  describe Adapter do
    context ".new" do
      it "doesn't accept nil delegate" do
        expect { Adapter.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context "#anemone_options" do
      it "forwards anemone_options from delegate" do
        delegate = double('delegate')
        delegate.stub(:anemone_options) {{:name => 'bob'}}

        adapter = Adapter.new(delegate)

        adapter.anemone_options.should eq({:name => 'bob'})
      end

      it "returns empty Hash if delegate has no options" do
        delegate = double('delegate')
        delegate.stub(:anemone_options) {nil}

        adapter = Adapter.new(delegate)

        adapter.anemone_options.should eq({})
      end

      it "returns empty Hash if delegate doesn't support anemone_options" do
        # Has no anemone_options method
        delegate = Object.new

        adapter = Adapter.new(delegate)

        adapter.anemone_options.should eq({})
      end
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

      it "ignores focus_crawl when delegate doesn't support it" do
        delegate = Object.new

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)
      end

      it "relays skip_links_like regex when delegate returns one" do
        delegate = double('delegate')
        delegate.stub(:skip_links_like) {/a/}

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)

        @anemone.last_skip_links_like_regexes.should eq([/a/])
      end

      it "relays skip_links_like regexes when delegate returns many" do
        delegate = double('delegate')
        delegate.stub(:skip_links_like) {[/a/, /b/]}

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)

        @anemone.last_skip_links_like_regexes.should eq([/a/, /b/])
      end

      it "ignores skip_links_like when not supported" do
        delegate = Object.new

        adapter = Adapter.new(delegate)

        adapter.hook_into_anemone(@anemone)
      end
    end # end of hooking into Anemone
  end # end of describe Adapter
end # end of Clownfish module
