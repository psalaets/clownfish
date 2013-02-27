require 'spec_helper'
require 'stringio'

module Clownfish
  describe LinksByPage do
    describe "#report" do
      before :each do
        @home = FakePage.new('home.com', 200)
        @links = FakePage.new('links.com', 200, 'home.com')
        @client = FakePage.new('client.com', 404, 'links.com')
        @server = FakePage.new('server.com', 500, 'links.com')
      end

      it "reports all statuses by default" do
        fish = LinksByPage.new

        fish.on_every_page(@client)
        fish.on_every_page(@server)

        out = StringIO.new
        fish.report(:to => out)

        out.string.should =~ %r{404 http://client.com\n500 http://server.com}
      end

      it "reports specified status when specifier given" do
        fish = LinksByPage.new

        fish.on_every_page(@client)
        fish.on_every_page(@server)

        out = StringIO.new
        fish.report(:to => out, :status => :server_error)

        out.string.should =~ %r{500 http://server.com}
        out.string.should_not =~ %r{404}
      end

      it "reports specified statuses when many specified" do
        fish = LinksByPage.new

        fish.on_every_page(@links)
        fish.on_every_page(@client)
        fish.on_every_page(@server)

        out = StringIO.new
        fish.report(:to => out, :status => [500, 200..204])

        out.string.should =~ %r{200 http://links.com}
        out.string.should =~ %r{500 http://server.com}
        out.string.should_not =~ %r{404}
      end

      it "page is not in report if it won't have any links shown" do
        fish = LinksByPage.new

        fish.on_every_page(@links)
        fish.on_every_page(@client)
        fish.on_every_page(@server)

        out = StringIO.new
        fish.report(:to => out, :status => [304])

        out.string.should_not =~ %r{http://home.com}
        out.string.should_not =~ %r{http://links.com}
      end
    end
  end
end