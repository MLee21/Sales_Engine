require_relative 'parser'
require_relative 'customer'

class CustomerRepository

  attr_reader :filename,
              :customers,
              :sales_engine
              # :repo,  
              ## ran rake spec without this variable and 
              # still ran after changing parse method
              ## not sure if it's necessary for rest of repo. don't delete until sure.           

  def self.load_csvs(filename, sales_engine)
    repo = self.allocate()
    parser = Parser.new(filename)
    customers = parser.parse.map do |customer|
      Customer.new(customer, repo)
    end
    repo.send(:initialize, customers, sales_engine)
    repo 
  end

  def initialize(customers, sales_engine)
    @customers = customers
    @sales_engine = sales_engine
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

  def find_by_id(id)
    customers.find { |customer| customer.id == id }
  end

  def find_by_first_name(name)
    customers.find { |customer| customer.first_name == name }
  end

  def find_by_last_name(name)
    customers.find { |customer| customer.last_name == name }
  end

  def find_by_created_at(date)
    customers.find { |customer| customer.created_at == date }
  end

  def find_by_updated_at(date)
    customers.find { |customer| customer.updated_at == date }
  end

  def find_all_by_id(id)
    customers.find_all { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    customers.find_all { |customer| customer.first_name == name }
  end

  def find_all_by_last_name(name)
    customers.find_all { |customer| customer.last_name == name }
  end

  def find_all_by_created_at(date)
    customers.find_all { |customer| customer.created_at == date }
  end

  def find_all_by_updated_at(date)
    customers.find_all { |customer| customer.updated_at == date }
  end

  def invoices(id)
    sale_engine.find_customer_invoices(id)
  end
end
