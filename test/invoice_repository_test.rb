require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < MiniTest::Test

  attr_reader :invoice_repo,
              :filename,
              :engine

  def setup
    @filename = "./test/data"
    @engine = SalesEngine.new(filename)
    @invoice_repo = InvoiceRepository.load_csvs("#{filename}/invoices.csv", engine)
  end

  def test_it_will_know_its_parent
    assert_equal engine, invoice_repo.sales_engine
  end

  def test_it_will_return_all_of_the_invoice_objects
    assert_equal 99, invoice_repo.all.count
  end

  def test_it_will_return_a_random_invoice
    assert_equal false, invoice_repo.random == invoice_repo.random
  end

  def test_it_will_find_invoice_by_id
    assert_equal 1, invoice_repo.find_by_id(1).id
  end

  def test_it_will_find_invoice_by_customer_id
    assert_equal 1, invoice_repo.find_by_customer_id(1).customer_id
  end

  def test_it_will_find_invoice_by_merchant_id
    assert_equal 26, invoice_repo.find_by_merchant_id(26).merchant_id
  end

  def test_it_will_find_invoice_by_status
    assert_equal "shipped", invoice_repo.find_by_status("shipped").status
  end

  def test_it_will_find_invoice_by_created_at
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), invoice_repo.find_by_created_at(Date.parse("2012-03-25 09:54:09 UTC")).created_at
  end

  def test_it_will_find_invoice_by_updated_at
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), invoice_repo.find_by_updated_at(Date.parse("2012-03-25 09:54:09 UTC")).updated_at
  end

  def test_it_will_find_all_invoice_by_id
    assert_equal 1, invoice_repo.find_all_by_id(1).count
  end

  def test_it_will_find_all_invoice_by_customer_id
    assert_equal 8, invoice_repo.find_all_by_customer_id(1).count
  end

  def test_it_will_find_all_invoice_by_merchant_id
    assert_equal 1, invoice_repo.find_all_by_merchant_id(26).count
  end

  def test_it_will_find_all_invoice_by_status
    assert_equal 99, invoice_repo.find_all_by_status("shipped").count
  end

  def test_it_will_find_all_invoice_by_created_at
    assert_equal 4, invoice_repo.find_all_by_created_at(Date.parse("2012-03-25 09:54:09 UTC")).count
  end

  def test_it_will_find_all_invoice_by_updated_at
    assert_equal 4, invoice_repo.find_all_by_updated_at(Date.parse("2012-03-25 09:54:09 UTC")).count
  end

  def test_it_will_return_transactions_associated_with_the_invoice
    sales_engine = MiniTest::Mock.new
    repo = InvoiceRepository.new(filename, sales_engine)
    sales_engine.expect(:find_merchant_by_invoice_id,[11],[11])
    assert_equal [11], repo.find_merchant_by_invoice_id(11)
    sales_engine.verify
  end

  def test_it_will_return_invoice_items_associated_with_the_invoice
    sales_engine = MiniTest::Mock.new
    repo = InvoiceRepository.new(filename, sales_engine)
    sales_engine.expect(:find_invoice_item_by_invoice_id,[3],[3])
    assert_equal [3], repo.find_by_invoice_item(3)
    sales_engine.verify
  end

  def test_it_will_return_items_associated_with_the_invoice
    sales_engine = MiniTest::Mock.new
    repo = InvoiceRepository.new(filename, sales_engine)
    sales_engine.expect(:find_invoice_item_by_invoice_id, [1],[1])
    assert_equal [1], repo.find_by_invoice_item(1)
    sales_engine.verify
  end

  def test_it_will_return_customers_associated_with_the_invoice
    sales_engine = MiniTest::Mock.new
    repo = InvoiceRepository.new(filename, sales_engine)
    sales_engine.expect(:find_customer_by_id, [1],[1])
    assert_equal [1], repo.find_customer(1)
    sales_engine.verify
  end

  def test_it_will_return_merchants_associated_with_the_invoice
    sales_engine = MiniTest::Mock.new
    repo = InvoiceRepository.new(filename, sales_engine)
    sales_engine.expect(:find_merchant_by_invoice_id, [1],[1])
    assert_equal [1], repo.find_merchant_by_invoice_id(1)
    sales_engine.verify
  end
end