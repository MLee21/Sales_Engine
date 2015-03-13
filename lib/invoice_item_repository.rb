require_relative 'parser'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :filename,
              :invoice_items,
              :parent,
              :repo

  def self.parse(filename, repo)
    parser = Parser.new(filename)
    invoice_items = parser.parse
    new(invoice_items.map {|h| InvoiceItems.new(h,self) }, repo) 
  end

  def initialize(invoice_items, parent)
    @invoice_items = invoice_items
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_items.id == id }
  end

  def find_by_item_id(id)
    invoice_items.find { |invoice_item| invoice_items.item_id == id }
  end

  def find_by_invoice_id(id)
    invoice_items.find { |invoice_item| invoice_items.invoice_id == id }
  end

  def find_by_quantity(amount)
    invoice_items.find { |invoice_item| invoice_items.quantity == amount }
  end

  def find_by_unit_price(unit)
    invoice_items.find { |invoice_item| invoice_items.unit_price == unit }
  end

  def find_by_created_at(date)
    invoice_items.find { |invoice_item| invoice_items.created_at == date }
  end

  def find_by_updated_at(date)
    invoice_items.find { |invoice_item| invoice_items.updated_at == date }
  end
end