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
    @status         = data[:status]
    @created_at     = data[:created_at]
    @updated_at     = data[:updated_at]
  end
end
