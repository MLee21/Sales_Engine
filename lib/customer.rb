class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repo

  def initialize(data, repo)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo       = repo
  end

  def invoices
    repo.find_invoices(id)
  end

  def customer_invoices
    customer_invoices = invoices.select do |invoice|
      invoice.customer
    end
  end

  def transactions
    customer_invoices.select do |invoice|
      invoice.transactions
    end
  end

  def favorite_merchant
    success = invoices.select do |invoice|
      invoice.successful_invoices
    end.flatten
    merchants = success.map do |invoice|
      invoice.merchant
    end
    merchants.max_by do |merchant|
      merchants.count(merchant)
    end
  end
end