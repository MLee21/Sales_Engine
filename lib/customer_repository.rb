require_relative 'parser'
require_relative 'customer'

class CustomerRepository

  attr_reader :filename,
              :customers,
              :parent,
              :repo

  def self.parse(filename, repo)
    parser = Parser.new(filename)
    customers = parser.parse
    new(customers.map {|h| Customer.new(h,self) }, repo) 
  end

  def initialize(customers, parent)
    @customers = customers
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_customers_by_id(id)
    customers.find { |customer| customer.id == id }
  end

  def find_customers_by_first_name(name)
    customers.find { |customer| customer.first_name == name }
  end

  def find_customers_by_last_name(name)
    customers.find { |customer| customer.last_name == name }
  end

  def find_customers_by_created_at(date)
    customers.find { |customer| customer.created_at == date }
  end

  def find_customers_by_updated_at(date)
    customers.find { |customer| customer.updated_at == date }
  end

  def find_all_customers_by_id(id)
    customers.find_all { |customer| customer.id == id }
  end

  def find_all_customers_by_first_name(name)
    customers.find_all { |customer| customer.first_name == name }
  end

  def find_all_customers_by_last_name(name)
    customers.find_all { |customer| customer.last_name == name }
  end

  def find_all_customers_by_created_at(date)
    customers.find_all { |customer| customer.created_at == date } 
  end

  def find_all_customers_by_updated_at(date)
    customers.find_all { |customer| customer.updated_at == date }
  end
end
