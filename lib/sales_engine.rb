require 'csv'
require 'pry'
require_relative './parser'
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
    @merchant_repository = MerchantRepository.load_csvs("#{data}/merchants.csv", self)
  end

  def item_repository
    @item_repository = ItemRepository.load_csvs("#{data}/items.csv", self)
  end

  def invoice_item_repository
    @invoice_item_repository = InvoiceItemRepository.load_csvs("#{data}/invoice_items.csv", self)
  end

  def invoice_repository
    @invoice_repository = InvoiceRepository.load_csvs("#{data}/invoices.csv", self)
  end

  def transaction_repository
    @transaction_repository = TransactionRepository.load_csvs("#{data}/transactions.csv", self)
  end

  def customer_repository
    customer_repository = CustomerRepository.load_csvs("#{data}/customers.csv", self)
  end

  def find_items_by_merchant_id(id)
    @item_repository.find_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    @invoice_repository.find_items_by_merchant_id(id)
  end

  def find_transactions_by_invoice_id(id)
    @transaction_repository.find_transaction_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    @invoice_item_repository.find_invoice_items_by_invoice_id(id)
  end

  def find_customer_invoices(id)
    @invoice_repository.find_all_by_customer_id(id)
  end

  def find_merchant_by_invoice_id(id)
    @merchant_repository.find_merchant_by_invoice_id(id)
  end

  def find_invoice_by_invoice_item(id)
    @invoice_repository.find_invoice_by_invoice_item(id)
  end

  def find_items_by_invoice_item(id)
    @item_repository.find_items_by_invoice_item(id)
  end

  def transaction_invoice(invoice_id)
    @invoice_repository.find_by_id(invoice_id)
  end

  def customer_invoices(invoice_id)
    @invoice_respository.find_all_by_id(invoice_id)
  end

  def item_invoice_items(invoice_item_id)
    @invoice_item_repository.find_all_by_item_id(invoice_item_id)
  end

  def item_merchant(merchant_id)
    @merchant_repository.find_by_id(merchant_id)
  end
end
