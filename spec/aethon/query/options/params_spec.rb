require File.expand_path('../../../../spec_helper', __FILE__)
require 'aethon'

describe Aethon::Query::Options, '#params' do
  let(:options) { Hash.new }

  subject { Aethon::Query::Options.new(options).params }

  describe 'when :field_list key is present' do
    let(:options) { { :field_list => "*" } }

    it "includes :fl key" do
      subject.must_equal(:fl => "*")
    end
  end

  describe 'when :query_fields key is present' do
    let(:options) { { :query_fields => "id^0.5" } }

    it "includes :qf key" do
      subject.must_equal(:qf => "id^0.5")
    end
  end

  describe 'when :sort key is present' do
    let(:options) { { :sort => "score" } }

    it "includes :sort key" do
      subject.must_equal(:sort => "score")
    end
  end

  describe 'when :offset key is present' do
    let(:options) { { :offset => 0 } }

    it "includes :start key" do
      subject.must_equal(:start => 0)
    end
  end

  describe 'when :limit key is present' do
    let(:options) { { :limit => 30 } }

    it "includes :rows key" do
      subject.must_equal(:rows => 30)
    end
  end

end
