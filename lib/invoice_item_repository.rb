require_relative 'parser'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :filename,
              :invoice_items,
              :sales_engine
              # :repo
              ## ran rake spec without this variable and 
              # still ran after changing parse method
              ## not sure if it's necessary for rest of repo. don't delete until sure.:repo
  def self.load_csvs(filename, sales_engine)
    repo = self.allocate()
    parser = Parser.new(filename)
    invoice_items = parser.parse.map do |invoice_item|
      InvoiceItem.new(invoice_item, repo)
    end
    repo.send(:initialize, invoice_items, sales_engine)
    repo 
  end

  def initialize(invoice_items, sales_engine)
    @invoice_items = invoice_items
    @sales_engine = sales_engine
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

  def find_by_name(name)
    invoice_items.find { |invoice_item| invoice_item.name == name }
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

  def find_all_by_name(name)
    invoice_items.find_all { |invoice_item| invoice_item.name == name }
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
    sales_engine.find_invoice_by_invoice_item(id)
  end

  def find_items_by_invoice_item(id)
    sales_engine.find_items_by_invoice_item(id)
  end
end
