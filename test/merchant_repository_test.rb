require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/parser'

class MerchantRepositoryTest < MiniTest::Test

  attr_accessor :file_path
  attr_reader :merchant_repo, :filename, :engine

  def setup
    @filename = './test/data/merchants.csv'
    @engine = SalesEngine.new(filename)
    @merchant_repo = MerchantRepository.parse(filename, engine)
  end

  def test_it_knows_its_parent
    assert_equal engine, merchant_repo.parent
  end

  def test_it_will_return_all_of_the_merchant_objects
    assert_equal 49, merchant_repo.all.count
  end
  
  def test_it_will_return_random_merchant
    assert_equal false, merchant_repo.random == merchant_repo.random
  end

  def test_it_will_find_by_id
    assert_equal 1, merchant_repo.find_by_id(1).id 
  end

  def test_it_will_find_by_name
    assert_equal "Klein, Rempel and Jones", merchant_repo.find_by_name("Klein, Rempel and Jones").name
  end

  def test_it_will_find_by_created_at
    assert_equal "2012-03-27 14:54:00 UTC", merchant_repo.find_by_created_at("2012-03-27 14:54:00 UTC").created_at
  end

  def test_it_will_find_by_updated_at
    assert_equal "2012-03-27 14:54:00 UTC", merchant_repo.find_by_updated_at("2012-03-27 14:54:00 UTC").updated_at
  end

  def test_it_will_find_all_by_id
    assert_equal 1, merchant_repo.find_all_by_id(1).count
  end

  def test_it_will_find_all_by_name
    assert_equal 1, merchant_repo.find_all_by_name("Cummings-Thiel").count
  end

  def test_it_will_find_all_by_created_at
    assert_equal 12, merchant_repo.find_all_by_created_at("2012-03-27 14:54:00 UTC").count
  end

  def test_it_will_find_all_by_updated_at
    assert_equal 12, merchant_repo.find_all_by_updated_at("2012-03-27 14:54:00 UTC").count
  end

  def test_it_will_return_items_associated_with_the_merchant
    sales_engine = MiniTest::Mock.new
    repo = MerchantRepository.new(filename, sales_engine)
    sales_engine.expect(:find_items_by_merchant_id,[1],[1])
    assert_equal [1], repo.find_items(1)
    sales_engine.verify
  end

  def test_it_will_return_a_different_item_associated_with_the_merchant
    sales_engine = MiniTest::Mock.new
    repo = MerchantRepository.new(filename, sales_engine)
    sales_engine.expect(:find_items_by_merchant_id,[2],[2])
    assert_equal [2], repo.find_items(2)
    sales_engine.verify
  end

  def test_it_will_return_invoices_associated_with_the_merchant
    sales_engine = MiniTest::Mock.new
    repo = MerchantRepository.new(filename, sales_engine)
    sales_engine.expect(:find_invoices_by_merchant_id,[26],[26])
    assert_equal [26], repo.find_invoices(26)
    sales_engine.verify
  end

  def test_it_will_return_invoices_associated_with_the_merchant
    sales_engine = MiniTest::Mock.new
    repo = MerchantRepository.new(filename, sales_engine)
    sales_engine.expect(:find_invoices_by_merchant_id, [76],[76])
    assert_equal [76], repo.find_invoices(76)
    sales_engine.verify
  end
end