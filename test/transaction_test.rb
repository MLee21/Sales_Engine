require 'simplecov'
SimpleCov.start
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require_relative '../lib/parser'

class TransactionTest < Minitest::Test

  attr_reader :filename,
              :engine,
              :transaction_repository 

  def setup
    @filename = "./test/data"
    @engine = SalesEngine.new(filename)
    @transaction_repository = TransactionRepository.load_csvs("#{filename}/transactions.csv", engine)
  end 

  def test_it_exists
    assert Transaction
  end

  def test_it_knows_its_parent
    assert_equal transaction_repository, transaction_repository.transactions.first.repo
  end

  def test_it_has_attributes_associated_with_the_transaction
    transaction = transaction_repository.transactions.first
    assert_equal 1, transaction.id 
    assert_equal 1, transaction.invoice_id
    assert_equal "4654405418249632", transaction.credit_card_number
    assert_equal nil, transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    assert_equal "2012-03-27 14:54:09 UTC", transaction.created_at
    assert_equal "2012-03-27 14:54:09 UTC", transaction.updated_at
  end

  def test_repo_finds_invoices_by_transaction
    repo = MiniTest::Mock.new
    transaction = Transaction.new({},repo)
    repo.expect(:find_invoice, "Billy Bob", [0])
    assert_equal "Billy Bob", transaction.invoice
    repo.verify
  end
end
