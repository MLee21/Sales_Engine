require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < MiniTest::Test

  attr_accessor :filename
  attr_reader :engine, :invoice_item_repo 

  def setup
    @filename = './test/data/invoice_items.csv'
    @engine = SalesEngine.new(filename)
    @invoice_item_repo = InvoiceItemRepository.parse(filename, engine)
  end

  def test_it_will_know_its_parent
    assert_equal engine, invoice_item_repo.parent
  end

  def test_it_will_return_all_of_the_item_objects
    assert_equal 99, invoice_item_repo.all.count
  end

  def test_it_will_return_a_random_item
    assert_equal false, invoice_item_repo.random == invoice_item_repo.random
  end

  # def test_it_will_find_items_by_id
  #   assert_equal 1, invoice_item_repo.find_by_id(1).id
  # end

  # def test_it_will_find_items_by_item_id
  #   assert_equal 539, invoice_item_repo.find_by_item_id(539).item_id
  # end

  # def test_it_will_find_items_by_invoice_id
  #   assert_equal 1, invoice_item_repo.find_by_invoice_id(1).invoice_id
  # end

  # def test_it_will_find_items_by_quantity
  #   assert_equal 5, invoice_item_repo.find_by_unit_price(5).quantity
  # end

  # def test_it_will_find_by_unit_price
  #   assert_equal 13635, invoice_item_repo.find_by_quantity(13635).unit_price
  # end

  # def test_it_will_find_when_item_was_created_at
  #   assert_equal "2012-03-27 14:54:09 UTC", invoice_item_repo.find_by_created_at("2012-03-27 14:54:09 UTC").created_at
  # end

  # def test_it_will_find_when_item_was_updated_at
  #   assert_equal "2012-03-27 14:54:09 UTC", invoice_item_repo.find_by_updated_at("2012-03-27 14:54:09 UTC").updated_at
  # end

  # def test_it_will_find_all_items_by_id
  #   assert_equal 1, invoice_item_repo.find_all_by_id(1).count
  # end

  # def test_it_will_find_all_items_by_item_id
  #   assert_equal 1, invoice_item_repo.find_all_by_name("Item Ea Voluptatum").count
  # end

  # def test_it_will_find_all_items_by_invoice_id
  #   assert_equal 1, invoice_item_repo.find_all_by_description(539).count
  # end

  # def test_it_will_find_all_items_by_quantity
  #   assert_equal 1, invoice_item_repo.find_all_by_unit_price(5).count
  # end

  # def test_it_will_find_all_items_by_unit_price
  #   assert_equal 1, invoice_item_repo.find_all_by_unit_price(66747).count
  # end

  # def test_it_will_find_all_items_by_created_at
  #   assert_equal 100, invoice_item_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  # end 

  # def test_it_will_find_all_items_by_updated_at
  #   assert_equal 100, invoice_item_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  # end
end