require_relative 'parser'
require_relative 'item'
require 'pry'
require 'bigdecimal'

class ItemRepository

  attr_reader :items,
              :filename,
              # :repo, ## ran rake spec without this variable and still ran after changing parse method
              ## not sure if it's necessary for rest of repo. don't delete until sure.
              :sales_engine

  def self.load_csvs(filename, sales_engine)
    repo = self.allocate()
    parser = Parser.new(filename)
    items = parser.parse.map do |item|
      Item.new(item, repo)
    end
    repo.send(:initialize, items, sales_engine)
    repo
  end

  def initialize(items, sales_engine)
    @items = items
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)
    items.find { |item| item.name == name }
  end

  def find_by_description(details)
    items.find { |item| item.description == details }
  end

  def find_by_unit_price(number)
    items.find { |item| item.unit_price == number }
  end

  def find_by_merchant_id(id)
    items.find { |item| item.merchant_id == id }
  end

  def find_by_created_at(date)
    items.find { |item| item.created_at == date }
  end

  def find_by_updated_at(date)
    items.find { |item| item.updated_at == date }
  end

  def find_all_by_id(id)
    items.find_all { |item| item.id == id }
  end

  def find_all_by_name(name)
    items.find_all { |item| item.name == name } 
  end

  def find_all_by_description(details)
    items.find_all { |item| item.description == details }
  end

  def find_all_by_unit_price(number)
    items.find_all { |item| item.unit_price == number }
  end

  def find_all_by_merchant_id(id)
    items.find_all { |item| item.merchant_id == id }
  end

  def find_all_by_created_at(date)
    items.find_all { |item| item.created_at == date }
  end

  def find_all_by_updated_at(date)
    items.find_all { |item| item.updated_at == date }
  end

  def find_invoice_item(id)
    sales_engine.find_invoice_item_by_item_id(id)
  end

  def find_merchant(id)
    sales_engine.find_item_by_merchant_id(id)
  end

end
