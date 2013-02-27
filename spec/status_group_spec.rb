require 'spec_helper'

module Clownfish
  describe StatusGroup do
    context "#<<" do
      it "takes alias Symbols, Integers and Integer Ranges" do
        group = StatusGroup.new

        group << :client_error
        group << 500
        group << 200..204

        group.include?(404).should be_true
        group.include?(500).should be_true
        group.include?(200).should be_true
        group.include?(304).should be_false
      end

      it "can be chained" do
        group = StatusGroup.new

        group << :client_error << 304 << :server_error

        group.include?(404).should be_true
        group.include?(500).should be_true
        group.include?(304).should be_true
        group.include?(200).should be_false
      end
    end

    context ".new" do
      it "can take a single status specifier" do
        group = StatusGroup.new(:server_error)

        group.include?(500).should be_true
        group.include?(200).should be_false
      end

      it "can take multiple status specifiers" do
        group = StatusGroup.new(200, :redirect, 400..406)

        group.include?(200).should be_true
        group.include?(301).should be_true
        group.include?(401).should be_true
        group.include?(204).should be_false
      end

      it "can take Array of status specifiers" do
        group = StatusGroup.new([:success, 500, 300..304])

        group.include?(500).should be_true
        group.include?(200).should be_true
        group.include?(302).should be_true
        group.include?(404).should be_false
      end
    end
  end
end