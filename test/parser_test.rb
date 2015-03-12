require 'simplecov'
SimpleCov.start
gem "minitest"
require "minitest"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/parser'

class ParserTest < MiniTest::Test

  attr_accessor :parser, :file_path

  def setup
    self.file_path = File.expand_path'../../test/data/merchants.csv',__FILE__
    @parser = Parser.new(file_path)
  end

  def test_it_parsed_into_a_file
    parser.parse
    assert parser.file
  end

  def test_parse_method_returns_first_element_in_data
    skip 
    #find correct syntax to test this
    assert_equal 0, parser.parse
  end















end
