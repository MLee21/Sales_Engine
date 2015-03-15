class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repo

  def initialize(data, parent)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo       = parent
  end

  def items(id)
    repo.find_items(id)
  end

  def invoices(id)
    repo.find_invoices(id)
  end 
end