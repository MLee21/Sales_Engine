require_relative 'parser'
require_relative 'transaction'

class TransactionRepository

  attr_reader :filename,
              :transactions,
              :sales_engine
              # :repo
              ## ran rake spec without this variable and 
              # still ran after changing parse method
              ## not sure if it's necessary for rest of repo. don't delete until sure.:repo

  def self.load_csvs(filename, sales_engine)
    repo = self.allocate()
    parser = Parser.new(filename)
    transactions = parser.parse.map do |transaction|
      Transaction.new(transaction, repo)
    end
    repo.send(:initialize, transactions, sales_engine)
    repo 
  end

  def initialize(transactions, sales_engine)
    @transactions = transactions
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction.id == id }
  end

  def find_by_invoice_id(id)
    transactions.find { |transaction| transaction.invoice_id == id }
  end

  def find_by_credit_card_number(number)
    transactions.find { |transaction| transaction.credit_card_number == number }
  end

  def find_by_credit_card_expiration_date(date)
    transactions.find { |transaction| transaction.credit_card_expiration_date == date }
  end

  def find_by_result(details)
    transactions.find { |transaction| transaction.result == details }
  end

  def find_by_created_at(date)
    transactions.find { |transaction| transaction.created_at == date }
  end

  def find_by_updated_at(date)
    transactions.find { |transaction| transaction.updated_at == date }
  end

  def find_all_by_id(id)
    transactions.find_all { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(id)
    transactions.find_all { |transaction| transaction.invoice_id == id }
  end

  def find_all_by_credit_card_number(number)
    transactions.find_all { |transaction| transaction.credit_card_number == number }
  end

  def find_all_by_credit_card_number_expiration_date(date)
    transactions.find_all { |transaction| transaction.credit_card_expiration_date == date }
  end

  def find_all_by_result(details)
    transactions.find_all { |transaction| transaction.result == details }
  end

  def find_all_by_created_at(date)
    transactions.find_all { |transaction| transaction.created_at == date }
  end

  def find_all_by_updated_at(date)
    transactions.find_all { |transaction| transaction.updated_at == date }
  end

  def invoice(invoice_id)
    sales_engine.transaction_invoice(invoice_id)
  end
end
