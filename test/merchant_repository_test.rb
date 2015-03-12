require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
# require "minitest"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test

  attr_accessor :file_path
  attr_reader :merchant_repo, :parent

  # def setup
  #    self.file_path = File.expand_path'../../test/data/merchants.csv',__FILE__
  #   @merchant_repo = MerchantRepository.new(file_path, parent)
  # end

  # def test_all
  #   assert_equal 0, merchant_repo.all
  # end









end