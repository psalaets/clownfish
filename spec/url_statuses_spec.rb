require 'spec_helper'

module Clownfish
  describe UrlStatuses do
    it "accumulates urls with status codes" do
      statuses = UrlStatuses.new

      statuses.add_url('http://ok.com', 200)
      statuses.add_url('http://huh.com', 404)

      statuses.status_codes_by_url.should eq({'http://ok.com' => 200, 'http://huh.com' => 404})
    end

    it "starts off empty" do
      statuses = UrlStatuses.new

      statuses.empty?.should be_true
    end

    it "knows how many urls it has" do
      statuses = UrlStatuses.new

      statuses.add_url('http://ok.com', 200)
      statuses.add_url('http://huh.com', 404)

      statuses.size.should eq(2)
    end

    context '#each' do
      it "yields url/code pairs to 2-arg block" do
        statuses = UrlStatuses.new

        statuses.add_url('http://ok.com', 200)
        statuses.add_url('http://huh.com', 404)

        pairs = []
        statuses.each { |k, v| pairs << [k, v] }

        pairs.should have_same_elements_as([['http://ok.com', 200], ['http://huh.com', 404]])
      end

      it "yields url/code Array to 1-arg block" do
        statuses = UrlStatuses.new

        statuses.add_url('http://ok.com', 200)
        statuses.add_url('http://huh.com', 404)

        pairs = []
        statuses.each { |p| pairs << p }

        pairs.should have_same_elements_as([['http://ok.com', 200], ['http://huh.com', 404]])
      end
    end

    context '#query' do
      it "returns url/status pairs that match a specifier" do
        statuses = UrlStatuses.new

        statuses.add_url('http://ok.com', 200)
        statuses.add_url('http://huh.com', 404)

        pairs = statuses.query(200)

        pairs.should have_same_elements_as([['http://ok.com', 200]])
      end

      it "returns url/status pairs that match any specifier" do
        statuses = UrlStatuses.new

        statuses.add_url('http://ok.com', 200)
        statuses.add_url('http://huh.com', 404)
        statuses.add_url('http://ohno.com', 500)

        pairs = statuses.query(200, :server_error)

        pairs.should have_same_elements_as([['http://ok.com', 200], ['http://ohno.com', 500]])
      end

      it "returns empty Array if no pairs match a specifier" do
        statuses = UrlStatuses.new

        statuses.add_url('http://ok.com', 200)
        statuses.add_url('http://huh.com', 404)

        pairs = statuses.query(500, :redirect)

        pairs.empty?.should be_true
      end
    end
  end
end