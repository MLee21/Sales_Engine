require_relative 'parser'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :filename,
              :invoices,
              :sales_engine
              # :repo ## ran rake spec without this variable
               # and still ran after changing parse method
              ## not sure if it's necessary for rest of repo. don't delete until sure.
          

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
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@invoice.size} rows>"
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
    invoices.find_all { |invoice| invoice.merchant_id == id }
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

  def find_transactions_by_invoice_id(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_customer_by_invoice_id(id)
    sales_engine.find_customer_by_invoice_id(id)
  end

  def find_merchant_by_invoice_id(id)
    sales_engine.find_merchant_by_invoice_id(id)
  end

  def find_items_by_invoice_items(id)
    sales_engine.find_items_by_invoice_id(id)
  end
end
