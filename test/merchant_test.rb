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
    directory = './test/data'
    @filename = "#{directory}/merchants.csv"
    @engine = SalesEngine.new(directory)
    @engine.startup
    @merchant_repository = MerchantRepository.load_csvs(filename, engine)
  end

  def test_it_exists
    assert Merchant
  end

  def test_it_knows_its_parent
    assert_equal merchant_repository, merchant_repository.merchants.first.repo
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

  def test_find_invoices_through_successful_transactions
    merchant = Merchant.new({:id=>1},merchant_repository)
    invoice_ids = merchant.successful_invoices.map do |invoice|
      invoice.id
    end 
    assert_equal [29], invoice_ids
  end

  def test_it_can_calculate_revenue
    merchant = Merchant.new({},merchant_repository)
    invoice1 = MiniTest::Mock.new
    invoice1.expect(:revenue, 120.50)
    invoice2 = MiniTest::Mock.new
    invoice2.expect(:revenue, 0.50)
    invoices = [invoice1,invoice2]
    merchant.stub :successful_invoices, invoices do
      assert_equal 121.00, merchant.revenue
    end
  end
end