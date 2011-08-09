require File.expand_path('../../../../spec_helper', __FILE__)
require 'aethon'

describe Aethon::Query::Options, '#merge' do
  let(:options) { Hash.new }
  let(:other)   { Hash.new }

  subject { Aethon::Query::Options.new(options).merge(other) }

  describe 'when :field_list key is present' do
    let(:options) { { :field_list => "*" } }

    it "includes :fl key" do
      subject.must_equal(:fl => "*")
    end
  end

end
