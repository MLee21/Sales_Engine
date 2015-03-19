require 'pry'
require 'date'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repo

  attr_writer :repo

  def initialize(data, repo)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo       = repo
  end

  def items
    repo.find_items(id)
  end

  def invoices
    repo.find_invoices(id)
  end

  def delinquent_invoices
    invoices.reject do |invoice|
      invoice.successful?
    end
  end

  def successful_invoices
    invoices.select do |invoice|
      invoice.successful?
    end
  end

  def successful_items
    successful_invoices.map do |invoice|
      invoice.items
    end.flatten.count
  end

  def revenue(date=nil)
    if date != nil
    successful_invoices
      .select { |invoice| invoice.created_at == date }
      .reduce(0) { |sum, invoice|
        sum + invoice.revenue
      }
    else
      successful_invoices.reduce(0) {| sum, invoice |
        sum + invoice.revenue
      }
    end
  end

  def favorite_customer
    selected_invoices = invoices.select {|invoice| invoice.successful_invoices}
    customers = selected_invoices.map {|invoice| invoice.customer}
    customers.max_by {|customer| customers.count(customer)}
  end

  def customers_with_pending_invoices
    delinquent_invoices.map do |invoice|
      invoice.customer
    end
  end
end
