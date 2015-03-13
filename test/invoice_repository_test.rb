require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < MiniTest::Test

  attr_accessor :filename
  attr_reader :engine, :invoice_repo

  def setup
    @filename = './test/data/invoices.csv'
    @engine = SalesEngine.new(filename)
    @invoice_repo = InvoiceRepository.parse(filename, engine)
  end

  def test_it_will_know_its_parent
    assert_equal engine, invoice_repo.parent
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
    assert_equal "2012-03-25 09:54:09 UTC", invoice_repo.find_by_created_at("2012-03-25 09:54:09 UTC").created_at
  end

  def test_it_will_find_invoice_by_updated_at
    assert_equal "2012-03-25 09:54:09 UTC", invoice_repo.find_by_updated_at("2012-03-25 09:54:09 UTC").updated_at
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
    assert_equal 1, invoice_repo.find_all_by_created_at("2012-03-25 09:54:09 UTC").count
  end

  def test_it_will_find_all_invoice_by_updated_at
    assert_equal 1, invoice_repo.find_all_by_updated_at("2012-03-25 09:54:09 UTC").count
  end
end