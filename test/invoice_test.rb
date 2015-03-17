require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/parser'

class InvoiceTest < MiniTest::Test

  attr_reader :filename, :invoice_repository, :engine 

  def setup
    @filename = './test/data/invoices.csv'
    @engine = SalesEngine.new(filename)
    @invoice_repository = InvoiceRepository.load_csvs(filename, engine)
  end

  def test_it_knows_its_parent
    assert_equal invoice_repository, invoice_repository.invoices.first.repo
  end

  def test_it_has_attributes_associated_with_the_invoice
    invoice = invoice_repository.invoices.first
    assert_equal 1, invoice.id 
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
    assert_equal "shipped", invoice.status
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
    assert_equal "2012-03-25 09:54:09 UTC",invoice.updated_at
  end

  def test_repo_finds_transactions_for_invoices
    repo = MiniTest::Mock.new
    invoice = Invoice.new({},repo)
    repo.expect(:find_by_invoice_id,[1],[0])
    assert_equal [1], invoice.transactions 
    repo.verify
  end

  def test_repo_finds_invoice_items_for_invoices
    repo = MiniTest::Mock.new
    invoice = Invoice.new({},repo)
    repo.expect(:find_invoice_item,[1],[0])
    assert_equal [1], invoice.invoice_items
    repo.verify
  end

  def test_repo_finds_items_for_invoices
    skip
    repo = MiniTest::Mock.new
    invoice = Invoice.new({},repo)
    repo.expect(:find_invoice_items_by_invoice_id,[1],[0])
    assert_equal 8, repo.invoice_items(0).items.size
    repo.verify
  end

  def test_repo_finds_customers_for_invoices
    repo = MiniTest::Mock.new
    invoice = Invoice.new({},repo)
    repo.expect(:find_customer, [1],[0])
    assert_equal [1], invoice.customer
    repo.verify
  end

  def test_repo_finds_merchants_for_invoices
    repo = MiniTest::Mock.new
    invoice = Invoice.new({},repo)
    repo.expect(:find_merchant_by_invoice_id, [1],[0])
    assert_equal [1], invoice.merchant 
    repo.verify
  end
end