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

  attr_reader :data,
              :merchant_repository,
              :item_repository,
              :invoice_item_repository,
              :invoice_repository,
              :transaction_repository,
              :customer_repository

  def initialize(data)
    @data = data
  end

  def startup
    @merchant_repository     = build_merchant_repository
    @item_repository         = build_item_repository
    @invoice_item_repository = build_invoice_item_repository
    @invoice_repository      = build_invoice_repository
    @transaction_repository  = build_transaction_repository
    @customer_repository     = build_customer_repository
  end

  def build_merchant_repository
    merchant_repo = MerchantRepository.load_csvs("#{data}/merchants.csv", self)
    merchant_repo ||= begin
      more_data = parse(data, "merchants.csv")
      MerchantRepository.new(more_data, self)
    end
  end

  def build_item_repository
    item_repo = ItemRepository.load_csvs("#{data}/items.csv", self)
    item_repo ||= begin
      more_data = parse(data, "items.csv")
      ItemRepository.new(more_data, self)
    end
  end

  def build_invoice_item_repository
    csv = "#{data}/invoice_items.csv"
    invoice_item_repo = InvoiceItemRepository.load_csvs(csv, self)
    invoice_item_repo ||= begin
      more_data = parse(data, "invoice_items.csv")
      InvoiceItemRepository.new(more_data, self)
    end
  end

  def build_invoice_repository
    invoice_repo = InvoiceRepository.load_csvs("#{data}/invoices.csv", self)
    invoice_repo ||= begin
      more_data = parse(data, "invoices.csv")
      InvoiceRepository.new(more_data, self)
    end
  end

  def build_transaction_repository
    csv = "#{data}/transactions.csv"
    transaction_repo = TransactionRepository.load_csvs(csv, self)
    transaction_repo ||= begin
      more_data = parse(data, "transactions.csv")
      TransactionRepository.new(more_data, self)
    end
  end

  def build_customer_repository
    customer_repo = CustomerRepository.load_csvs("#{data}/customers.csv", self)
    customer_repo ||= begin
      more_data = parse(data, "customers.csv")
      CustomerRepository.new(more_data, self)
    end
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_invoice_by_invoice_id(id)
    transaction_repository.find_by_invoice_id(id)
  end

  def find_invoice_item_by_invoice_id(id)
    invoice_item_repository.find_by_invoice_id(id)
  end

  def find_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_merchant_by_invoice_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_invoice_by_invoice_item(id)
    invoice_repository.find_by_id(id)
  end

  def find_item_by_invoice_item(id)
    item_repository.find_by_id(id)
  end

  def find_invoice_by_transaction(id)
    invoice_repository.find_by_id(id)
  end

  def find_customer_by_id(id)
    customer_repository.find_by_id(id)
  end

  def find_invoice_item_by_item_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_item_by_merchant_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transaction_repository.find_all_by_invoice_id(id)
  end

  def find_invoice_item_by_invoice_id(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def successful_transactions_from_invoice_id(id)
    if find_transactions_by_invoice_id(id).nil?
      false
    else
      find_transactions_by_invoice_id(id).any? do |trans|
        trans.result == "success"
      end
    end
  end

  def add_items(items, id)
   invoice_item_repository.add_items(items, id)
  end

  def charge(card, id)
    transaction_repository.create_new_transaction(card, id)
  end
end
