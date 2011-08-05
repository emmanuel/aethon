require File.expand_path('../../../../spec_helper', __FILE__)
require 'aethon'

describe Aethon::Query::Options do
  def options; {}; end
  def other;   {}; end

  before do
    @subject = Aethon::Query::Options.new(options).merge(other)
  end

  describe 'when :field_list key is present' do
    def options; { :field_list => "*" } end

    it "includes :fl key" do
      @subject.must_equal(:fl => "*")
    end
  end

end
