class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @id             = data[:id].to_i
    @customer_id    = data[:customer_id]
    @merchant_id    = data[:merchant_id]
    @status         = data[:status]
    @created_at     = data[:created_at]
    @updated_at     = data[:updated_at]
  end

  def invoice_items
    repo.find_invoice_items_by_invoice_id(id)
  end

  def transactions
    repo.find_transactions_by_invoice_id(id)
  end

  def customers
    repo.find_customers_by_invoice_id(id)
  end
  
  # def items
  #   invoice_items
  # end


end

