require_relative 'parser'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :filename,
              :invoice_items,
              :sales_engine,
              :invoice_items_by_item_id

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
    @invoice_items_by_item_id = @invoice_items.reduce({}) do |hash, invoice_item|
      unless hash.include?(invoice_item.item_id)
        hash[invoice_item.item_id] = []
      end
      hash[invoice_item.item_id] << invoice_item
      hash
    end
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
    #invoice_items.find_all { |invoice_item| invoice_item.item_id == id }
    invoice_items_by_item_id[id] || []
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

  def find_invoice(id)
    sales_engine.find_invoice_by_invoice_item(id)
  end

  def find_item(id)
    sales_engine.find_item_by_invoice_item(id)
  end

   def next_id
    invoice_items.last.id + 1
  end

 def add_items(items, id)
    items.each do |item|
      grouped_items = items.group_by do |item|
        item
      end
      quantity = grouped_items.map do |item|
        item.count
      end.uniq.flatten.join
      data = {
        id:                 next_id,
        item_id:            item.id,
        invoice_id:              id,
        quantity:          quantity,
        unit_price: item.unit_price,
        created_at:   "#{Time.new}",
        updated_at:   "#{Time.new}",
      }
      invoice_item = InvoiceItem.new(data, self)
      @invoice_items << invoice_item
    end
  end
end
