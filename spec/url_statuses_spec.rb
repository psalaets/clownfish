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

      statuses.empty?.should eq(true)
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
  end
end