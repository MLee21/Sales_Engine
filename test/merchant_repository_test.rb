require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
# require "minitest"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/merchant_repository'
require_relative '../lib/parser'

class MerchantRepositoryTest < MiniTest::Test

  attr_accessor :file_path
  attr_reader :merchant_repo, :parent

  def setup
    self.file_path = File.expand_path'../../test/data/merchants.csv',__FILE__
    @merchant_repo = MerchantRepository.parse(file_path, parent)
  end

  def test_it_will_return_all_of_the_merchant_objects
    assert_equal "", merchant_repo.all
  end

end