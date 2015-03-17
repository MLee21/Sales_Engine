require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repo

  def initialize(data, repo)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = (BigDecimal.new(data[:unit_price]))/100
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repo        = repo
  end

  def invoice_items
    repo.find_invoice_item(id)
  end

  def merchant
    repo.find_merchant(merchant_id)
  end
end
