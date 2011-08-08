require 'minitest/autorun'

lib_path = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_path unless $LOAD_PATH.include?(lib_path)

class Aethon::Spec < MiniTest::Spec

  class << self
    attr_accessor :let_blocks
    attr_accessor :let_values
    attr_accessor :subject_block
  end

  self.subject_block = lambda { raise ArgumentError, "no subject given" }

  def self.subject(&block)
    self.subject_block = block
  end

  def subject
    @subject ||= self.class.subject_block.call
  end

  self.let_blocks = {}
  self.let_values = {}

  def self.let(name, &block)
    raise ArgumentError, "block expected" unless block_given?

    # initialize with empty values for subclasses
    self.let_blocks ||= {}
    self.let_values ||= {}

    define_method(name) do
      _let_values(name) do
        self.class.let_values[name] = self.class.let_blocks.fetch(name) do
          block.call
        end
      end
    end
  end

  def self.let_value(name, &block)
    let_values = self.let_values
    let_blocks = self.let_blocks

    let_values.fetch(name) do
      let_values[name] = superclass.let_value(name) || yield
    end
  end

  def let_block(name)
    let_blocks = self.class.let_blocks
    let_blocks.fetch(name) do
      
    end
  end

end
