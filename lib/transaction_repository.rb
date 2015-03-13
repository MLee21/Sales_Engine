require_relative 'parser'
require_relative 'transaction'

class TransactionRepository

  attr_reader :filename,
              :transactions,
              :parent,
              :repo 

  def self.parse(filename, repo)
    parser = Parser.new(filename)
    transactions = parser.parse
    new(transactions.map {|h| Transaction.new(h,self) }, repo) 
  end

  def initialize(transactions, parent)
    @transactions = transactions
    @parent = parent
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

  def find_transaction_by_id(id)
    transactions.find { |transaction| transaction.id == id }
  end

  def find_transaction_by_invoice_id(id)
    transactions.find { |transaction| transaction.invoice_id == id }
  end

  def find_transaction_by_credit_card_number(number)
    transactions.find { |transaction| transaction.credit_card_number == number }
  end

  def find_transaction_by_credit_card_expiration_date(date)
    transactions.find { |transaction| transaction.credit_card_number_expiration_date == date }
  end

  def find_transaction_by_result(details)
    transactions.find { |transaction| transaction.result == details }
  end

  def find_transaction_by_created_at(date)
    transactions.find { |transaction| transaction.created_at == date }
  end

  def find_transaction_by_updated_at(date)
    transactions.find { |transaction| transaction.updated_at == date }
  end

  def find_all_transactions_by_id(id)
    transactions.find_all { |transaction| transaction.id == id }
  end

  def find_all_transactions_by_invoice_id(id)
    transactions.find_all { |transaction| transaction.invoice_id == id }
  end

  def find_all_transactions_by_credit_card_number(number)
    transactions.find_all { |transaction| transaction.credit_card_number == number }
  end

  def find_all_transactions_by_credit_card_number_expiration_date(date)
    transactions.find_all { |transaction| transaction.credit_card_card_expiration_date == date }
  end

  def find_all_transactions_by_result(details)
    transactions.find_all { |transaction| transaction.result == details }
  end

  def find_all_transactions_by_created_at(date)
    transactions.find_all { |transaction| transaction.created_at == date }
  end

  def find_all_transactions_by_updated_at(date)
    transactions.find_all { |transaction| transaction.updated_at == date }
  end
end