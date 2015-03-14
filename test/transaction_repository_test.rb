require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < MiniTest::Test

  attr_accessor :filename
  attr_reader :engine, :trans_repo

  def setup
    @filename = './test/data/transactions.csv'
    @engine = SalesEngine.new(filename)
    @trans_repo = TransactionRepository.parse(filename, engine)
  end

  def test_it_will_know_its_parent
    assert_equal engine, trans_repo.parent
  end

  def test_it_will_return_all_of_the_transaction_objects
    assert_equal 99, trans_repo.all.count
  end

  def test_it_will_find_transaction_by_id
    assert_equal 1, trans_repo.find_transaction_by_id(1).id
  end

  def test_it_will_find_transaction_by_invoice_id
    assert_equal 10, trans_repo.find_transaction_by_invoice_id(10).invoice_id
  end

  def test_it_will_find_transaction_by_credit_card_number
    assert_equal 4540842003561938, trans_repo.find_transaction_by_credit_card_number(4540842003561938).credit_card_number
  end

  def test_it_will_find_transaction_by_credit_card_number_expirated_date
    assert_equal nil, trans_repo.find_transaction_by_credit_card_expiration_date(nil).credit_card_expiration_date
  end

  def test_it_will_find_transaction_by_result
    assert_equal "failed", trans_repo.find_transaction_by_result("failed").result
  end

  def test_it_will_find_transaction_by_created_at
    assert_equal "2012-03-27 14:54:09 UTC", trans_repo.find_transaction_by_created_at("2012-03-27 14:54:09 UTC").created_at
  end

  def test_it_will_find_transaction_by_updated_at
    assert_equal "2012-03-27 14:54:09 UTC", trans_repo.find_transaction_by_updated_at("2012-03-27 14:54:09 UTC").updated_at
  end

  def test_it_will_find_all_transactions_by_id
    assert_equal 1, trans_repo.find_all_transactions_by_id(3).count
  end

  def test_it_will_find_all_transactions_by_invoice_id
    assert_equal 1, trans_repo.find_all_transactions_by_invoice_id(1).count
  end

  def test_it_will_find_all_transactions_by_credit_card_number
    assert_equal 1, trans_repo.find_all_transactions_by_credit_card_number(4654405418249632).count
  end

  def test_it_will_find_all_transactions_by_credit_card_number_expiration_date
    assert_equal 99, trans_repo.find_all_transactions_by_credit_card_number_expiration_date(nil).count
  end

  def test_it_will_find_all_transactions_by_result
    assert_equal 83, trans_repo.find_all_transactions_by_result("success").count
  end

  def test_it_will_find_all_transactions_by_created_at
    assert_equal 2, trans_repo.find_all_transactions_by_created_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_will_find_all_transactions_by_updated_at
    assert_equal 2, trans_repo.find_all_transactions_by_updated_at("2012-03-27 14:54:09 UTC").count
  end
end
