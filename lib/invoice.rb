require 'pry'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo

  def initialize(data, repo)
    @id             = data[:id].to_i
    @customer_id    = data[:customer_id].to_i
    @merchant_id    = data[:merchant_id].to_i
    @status         = data[:status]
    @created_at     = data[:created_at]
    @updated_at     = data[:updated_at]
    @repo           = repo
  end

  def invoice_items
    repo.find_invoice_item(id)
  end

  def transactions
    repo.find_by_invoice_id(id)
  end

  def customer
    repo.find_customer(customer_id)
  end

  def merchant
    repo.find_merchant_by_invoice_id(id)
  end

  def items
    invoice_items.map { |invoice_item| invoice_item.item }
  end

  def successful?
    transactions.any? { |transaction| transaction.result == "success"}
  end

   def revenue
    invoice_items.reduce(0) do |sum, invoice_item|
      sum + (invoice_item.quantity * invoice_item.unit_price)
    end
  end 
end

