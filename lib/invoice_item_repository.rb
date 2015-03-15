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
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(id)
    invoice_items.find { |invoice_item| invoice_item.item_id == id }
  end

  def find_by_invoice_id(id)
    invoice_items.find { |invoice_item| invoice_item.invoice_id == id }
  end

  def find_by_quantity(amount)
    invoice_items.find { |invoice_item| invoice_item.quantity == amount }
  end

  def find_by_unit_price(unit)
    invoice_items.find { |invoice_item| invoice_item.unit_price == unit }
  end

  def find_by_created_at(date)
    invoice_items.find { |invoice_item| invoice_item.created_at == date }
  end

  def find_by_updated_at(date)
    invoice_items.find { |invoice_item| invoice_item.updated_at == date }
  end

  def find_all_by_id(id)
    invoice_items.find_all { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    invoice_items.find_all { |invoice_item| invoice_item.invoice_id == id }
  end

  def find_all_by_quantity(amount)
    invoice_items.find_all { |invoice_item| invoice_item.quantity == amount }
  end

  def find_all_by_unit_price(unit)
    invoice_items.find_all { |invoice_item| invoice_item.unit_price == unit }
  end

  def find_all_by_created_at(date)
    invoice_items.find_all { |invoice_item| invoice_item.created_at == date }
  end

  def find_all_by_updated_at(date)
    invoice_items.find_all { |invoice_item| invoice_item.updated_at == date }
  end

  def find_invoice_by_invoice_item(id)
    parent.find_invoice_by_invoice_item(id)
  end

  def find_items_by_invoice_item(id)
    parent.find_items_by_invoice_item(id)
  end
end
