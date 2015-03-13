require_relative 'parser'
require_relative 'item'

class ItemRepository

  attr_reader :items, 
              :filename,
              :repo,
              :parent

  def self.parse(filename, repo)
    parser = Parser.new(filename)
    items = parser.parse 
    new(items.map {|h| Items.new(h,self) }, repo)    
  end

  def initialize(items, parent) 
    @items = items
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
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


end