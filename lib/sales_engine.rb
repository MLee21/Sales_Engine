require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_item_repository'
require_relative './invoice_repository'
require_relative './transaction_repository'
require_relative './customer_repository'

class SalesEngine

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def startup
    merchant_repository
    item_repository
    invoice_item_repository
    invoice_repository
    transaction_repository
    customer_repository
  end

  def merchant_repository
    @merchant_repository = MerchantRepository.new("path/to/csv", self)
  end

  def item_repository
    @item_repository = ItemRepository.new("path/to/csv", self)
  end

  def invoice_item_repository
    @invoice_item_repository = InvoiceItemRepository.new("path/to/csv", self)
  end

  def invoice_repository
    @invoice_repository = InvoiceRepository.new("path/to/csv", self)
  end

  def transaction_repository
    @transaction_repository = TransactionRepository.new("path/to/csv", self)
  end

  def customer_repository
    @customer_repository = CustomerRepository.new("path/to/csv", self)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_items_by_merchant_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transaction_repository.find_transaction_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_invoice_items_by_invoice_id(id)
  end

  def find_customers_by_invoice_id(id)
    customer_repository.find_customers_by_invoice_id(id)
  end

  def find_merchants_by_invoice_id(id)
    merchant_repository.find_merchants_by_invoice_id(id)
  end
end