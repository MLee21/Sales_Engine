require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/parser'

class MerchantTest < MiniTest::Test

  attr_reader :filename, :merchant_repository, :engine, :merchants
  
  def setup
    @filename = './test/data/merchants.csv'
    @engine = SalesEngine.new(filename)
    @merchant_repository = MerchantRepository.parse(filename, engine)
  end

  def test_it_exists
    assert Merchant
  end

  def test_it_knows_its_parent
    assert_equal merchant_repository.class, merchant_repository.merchants.first.repo
  end

  def test_it_has_attributes_associated_with_the_merchant
    merchant = merchant_repository.merchants.first
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal 1, merchant.id
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_repo_finds_items_for_merchant
    repo = Minitest::Mock.new
    merchant = Merchant.new({},repo)
    repo.expect(:find_items, [1], [0])
    assert_equal [1], merchant.items
    repo.verify
  end

  def test_repo_finds_invoices_for_merchant
    repo = MiniTest::Mock.new
    merchant = Merchant.new({},repo)
    repo.expect(:find_invoices,[1],[0])
    assert_equal [1], merchant.invoices
    repo.verify
  end
end