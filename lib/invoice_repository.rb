require_relative 'parser'
require_relative 'invoice'
require 'pry'

class InvoiceRepository

  attr_reader :filename,
              :invoices,
              :sales_engine,
              :invoices_by_merchant_id

  def self.load_csvs(filename, sales_engine)
    repo = self.allocate()
    parser = Parser.new(filename)
    invoices = parser.parse.map do |invoice|
      Invoice.new(invoice, repo)
    end
    repo.send(:initialize, invoices, sales_engine)
    repo
  end

  def initialize(invoices, sales_engine)
    @invoices = invoices
    @invoices_by_merchant_id = @invoices.reduce({}) do |hash, invoice|
      unless hash.include?(invoice.merchant_id)
        hash[invoice.merchant_id] = []
      end
      hash[invoice.merchant_id] << invoice
      hash
    end
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find { |invoice| invoice.id == id }
  end

  def find_by_customer_id(id)
    invoices.find { |invoice| invoice.customer_id == id }
  end

  def find_by_merchant_id(id)
    invoices.find { |invoice| invoice.merchant_id == id }
  end

  def find_by_status(details)
    invoices.find { |invoice| invoice.status == details }
  end

  def find_by_created_at(date)
    invoices.find { |invoice| invoice.created_at == date }
  end

  def find_by_updated_at(date)
    invoices.find { |invoice| invoice.updated_at == date }
  end

  def find_all_by_id(id)
    invoices.find_all { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(id)
    invoices.find_all { |invoice| invoice.customer_id == id }
  end

  def find_all_by_merchant_id(id)
    invoices_by_merchant_id[id] || []
    # invoices.find_all { |invoice| invoice.merchant_id == id }
  end

  def find_all_by_status(details)
    invoices.find_all { |invoice| invoice.status == details }
  end

  def find_all_by_created_at(date)
    invoices.find_all { |invoice| invoice.created_at == date }
  end

  def find_all_by_updated_at(date)
    invoices.find_all { |invoice| invoice.updated_at == date }
  end

  def find_transactions(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_by_invoice_item(id)
    sales_engine.find_invoice_item_by_invoice_id(id)
  end

  def find_customer(id)
    sales_engine.find_customer_by_id(id)
  end

  def find_merchant_by_invoice_id(id)
    sales_engine.find_merchant_by_invoice_id(id)
  end

  def find_invoice_item(id)
    sales_engine.find_invoice_item_by_invoice_id(id)
  end

  def next_id
    invoices.last.id + 1
  end

  def create(inputs)
    data = {
     id:                       next_id,
     customer_id: inputs[:customer].id,
     merchant_id: inputs[:merchant].id,
     status:                 "shipped",
     created_at:         "#{Time.new}",
     updated_at:         "#{Time.new}",
    }
   invoice = Invoice.new(data, self)
   @invoices << invoice

   sales_engine.add_items(inputs[:items], invoice.id)
   invoice
  end

  def charge(information, id)
    sales_engine.charge(information, id)
  end
end
