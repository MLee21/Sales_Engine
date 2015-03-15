require_relative 'parser'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :filename,
              :invoices,
              :parent,
              :repo 

  def self.parse(filename, repo)
    parser = Parser.new(filename)
    invoices = parser.parse
    new(invoices.map {|h| Invoice.new(h,self) }, repo) 
  end

  def initialize(invoices, parent)
    @invoices = invoices
    @parent = parent
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

  def find_transactions(id)
    parent.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items(id)
    parent.find_invoice_items_by_invoice_id(id)
  end

  def find_customers(id)
    parent.find_customers_by_invoice_id(id)
  end

  def find_merchants(id)
    parent.find_merchants_by_invoice_id(id)
  end
end