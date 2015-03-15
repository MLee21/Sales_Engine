require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/parser'

class InvoiceItemTest < MiniTest::Test

  attr_reader :filename, :engine, :invoice_item_repository

  def setup
    @filename = './test/data/invoice_items.csv'
    @engine = SalesEngine.new(filename)
    @invoice_item_repository = InvoiceItemRepository.parse(filename, engine)
  end

  def test_it_knows_its_parent
    assert_equal invoice_item_repository.class, invoice_item_repository.invoice_items.first.repo
  end

  def test_it_has_attributes_associated_with_the_invoice_items
    invoice_item = invoice_item_repository.invoice_items.first
    assert_equal 1, invoice_item.id 
    assert_equal 539, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 5, invoice_item.quantity
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.created_at
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.updated_at
  end

  def test_repo_finds_invoices_by_invoice_item
    repo = MiniTest::Mock.new
    invoice_item = InvoiceItems.new({},repo)
    repo.expect(:find_invoices_by_invoice_item,[1],[0])
    assert_equal [1], invoice_item.invoice
    repo.verify
  end

  def test_repo_finds_items_by_invoice_item
    repo = MiniTest::Mock.new
    invoice_item = InvoiceItems.new({},repo)
    repo.expect(:find_items_by_invoice_item, [539],[0])
    assert_equal [539], invoice_item.item
    repo.verify
  end
end