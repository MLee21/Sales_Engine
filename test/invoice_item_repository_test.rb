require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < MiniTest::Test

  attr_reader :engine, 
              :invoice_item_repo, 
              :filename

  def setup
    @filename = "./test/data"
    @engine = SalesEngine.new(filename)
    @invoice_item_repo = InvoiceItemRepository.load_csvs("#{filename}/invoice_items.csv", engine)
  end

  def test_it_will_know_its_parent
    assert_equal engine, invoice_item_repo.sales_engine
  end

  def test_it_will_return_all_of_the_item_objects
    assert_equal 99, invoice_item_repo.all.count
  end

  def test_it_will_return_a_random_item
    assert_equal false, invoice_item_repo.random == invoice_item_repo.random
  end

  def test_it_will_find_items_by_id
    assert_equal 1, invoice_item_repo.find_by_id(1).id
  end

  def test_it_will_find_items_by_item_id
    assert_equal 539, invoice_item_repo.find_by_item_id(539).item_id
  end

  def test_it_will_find_items_by_invoice_id
    assert_equal 1, invoice_item_repo.find_by_invoice_id(1).invoice_id
  end

  def test_it_will_find_items_by_quantity
    assert_equal 5, invoice_item_repo.find_by_quantity(5).quantity
  end

  def test_it_will_find_by_unit_price
    assert_equal 13635, invoice_item_repo.find_by_unit_price(13635).unit_price
  end

  def test_it_will_find_when_item_was_created_at
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item_repo.find_by_created_at("2012-03-27 14:54:09 UTC").created_at
  end

  def test_it_will_find_when_item_was_updated_at
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item_repo.find_by_updated_at("2012-03-27 14:54:09 UTC").updated_at
  end

  def test_it_will_find_all_items_by_id
    assert_equal 1, invoice_item_repo.find_all_by_id(1).count
  end

  def test_it_will_find_all_items_by_item_id
    assert_equal 1, invoice_item_repo.find_all_by_item_id(535).count
  end

  def test_it_will_find_all_items_by_invoice_id
    assert_equal 4, invoice_item_repo.find_all_by_invoice_id(2).count
  end

  def test_it_will_find_all_items_by_quantity
    assert_equal 8, invoice_item_repo.find_all_by_quantity(9).count
  end

  def test_it_will_find_all_items_by_unit_price
    assert_equal 1, invoice_item_repo.find_all_by_unit_price(66747).count
  end

  def test_it_will_find_all_items_by_created_at
    assert_equal 15, invoice_item_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  end 

  def test_it_will_find_all_items_by_updated_at
    assert_equal 15, invoice_item_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  end

   def test_it_will_return_invoices_associated_with_the_invoice_items
    sales_engine = MiniTest::Mock.new
    repo = InvoiceItemRepository.new(filename, sales_engine)
    sales_engine.expect(:find_invoice_by_invoice_item,[1],[1])
    assert_equal [1], repo.find_invoice(1)
    sales_engine.verify
  end

  def test_it_will_return_items_associated_with_the_invoice_items
    sales_engine = MiniTest::Mock.new
    repo = InvoiceItemRepository.new(filename, sales_engine)
    sales_engine.expect(:find_item_by_invoice_item, [1],[1])
    assert_equal [1], repo.find_item(1)
    sales_engine.verify
  end
end