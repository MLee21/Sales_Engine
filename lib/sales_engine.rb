require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_item_repository'

class SalesEngine

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def startup
    merchant_repository
    item_repository
    invoice_item_repository
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
end