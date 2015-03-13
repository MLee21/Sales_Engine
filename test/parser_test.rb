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
    @parser = Parser.new('./test/data/merchants.csv')
  end

  def test_it_parsed_into_a_file
    parser.parse
    assert parser.file
  end

  def test_it_will_return_the_first_attribute_in_data
    assert_equal 1, parser.parse[0][:id]
  end

  def test_it_will_return_the_second_attribute_in_data
    assert_equal "Schroeder-Jerde", parser.parse[0[1]][:name]
  end

  def test_it_will_return_the_third_attribute_in_data
    assert_equal "2012-03-27 14:53:59 UTC", parser.parse[0[2]][:created_at]
  end

  def test_it_will_return_the_fourth_attribute_in_data
    assert_equal "2012-03-27 14:53:59 UTC", parser.parse[0[3]][:updated_at]
  end

  def test_it_will_return_an_attribute_from_a_different_row
    assert_equal "Klein, Rempel and Jones", parser.parse[7[1]][:name]
  end
end

