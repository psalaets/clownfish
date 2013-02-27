require 'spec_helper'

module Clownfish
  describe StatusGroup do
    it "is fillable with group Symbols, Integers and Integer Ranges" do
      group = StatusGroup.new

      group << :client_error
      group << 500
      group << 200..204

      group.include?(404).should eq(true)
      group.include?(500).should eq(true)
      group.include?(200).should eq(true)
      group.include?(304).should eq(false)
    end

    it "can chain calls when adding status specifiers" do
      group = StatusGroup.new

      group << :client_error << 304 << :server_error

      group.include?(404).should eq(true)
      group.include?(500).should eq(true)
      group.include?(304).should eq(true)
      group.include?(200).should eq(false)
    end

    it "can be created from one status specifier" do
      group = StatusGroup.new(:server_error)

      group.include?(500).should eq(true)
      group.include?(200).should eq(false)
    end

    it "can be created from many status specifiers" do
      group = StatusGroup.new(200, :redirect, 400..406)

      group.include?(200).should eq(true)
      group.include?(301).should eq(true)
      group.include?(401).should eq(true)
      group.include?(204).should eq(false)
    end

    it "can be created from Array of status specifiers" do
      group = StatusGroup.new([:success, 500, 300..304])

      group.include?(500).should eq(true)
      group.include?(200).should eq(true)
      group.include?(302).should eq(true)
      group.include?(404).should eq(false)
    end
  end
end