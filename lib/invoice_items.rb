class InvoiceItems

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @id         = data[:id].to_i
    @item_id    = data[:data_id]
    @invoice_id = data[:invoice_id]
    @quantity   = data[:quantity]
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end
end
















end
=======
>>>>>>> repo_work_ML
