require 'bigdecimal/util'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repo        = parent
  end

  def invoice_items
    repo.invoice_items(id)
  end

  def merchant
    repo.merchant(id)
  end

end
