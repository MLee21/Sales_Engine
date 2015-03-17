require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < MiniTest::Test

  attr_reader :trans_repo,
              :filename,
              :engine

  def setup
    @filename = "./test/data"
    @engine = SalesEngine.new(filename)
    @trans_repo = TransactionRepository.load_csvs("#{filename}/transactions.csv", engine)
  end
  def test_it_will_know_its_parent
    assert_equal engine, trans_repo.sales_engine
  end

  def test_it_will_return_all_of_the_transaction_objects
    assert_equal 99, trans_repo.all.count
  end

  def test_it_will_find_transaction_by_id
    assert_equal 1, trans_repo.find_by_id(1).id
  end

  def test_it_will_find_transaction_by_invoice_id
    assert_equal 9, trans_repo.find_by_invoice_id(10).id
  end

  def test_it_will_find_transaction_by_credit_card_number
    assert_equal "4540842003561938", trans_repo.find_by_credit_card_number("4540842003561938").credit_card_number
  end

  def test_it_will_find_transaction_by_credit_card_number_expirated_date
    assert_equal nil, trans_repo.find_by_credit_card_expiration_date(nil).credit_card_expiration_date
  end

  def test_it_will_find_transaction_by_result
    assert_equal "failed", trans_repo.find_by_result("failed").result
  end

  def test_it_will_find_transaction_by_created_at
    assert_equal "2012-03-27 14:54:09 UTC", trans_repo.find_by_created_at("2012-03-27 14:54:09 UTC").created_at
  end

  def test_it_will_find_transaction_by_updated_at
    assert_equal "2012-03-27 14:54:09 UTC", trans_repo.find_by_updated_at("2012-03-27 14:54:09 UTC").updated_at
  end

  def test_it_will_find_all_transactions_by_id
    assert_equal 1, trans_repo.find_all_by_id(3).count
  end

  def test_it_will_find_all_transactions_by_invoice_id
    assert_equal 1, trans_repo.find_all_by_invoice_id(1).count
  end

  def test_it_will_find_all_transactions_by_credit_card_number
    assert_equal 1, trans_repo.find_all_by_credit_card_number("4654405418249632").count
  end

  def test_it_will_find_all_transactions_by_credit_card_number_expiration_date
    assert_equal 99, trans_repo.find_all_by_credit_card_number_expiration_date(nil).count
  end

  def test_it_will_find_all_transactions_by_result
    assert_equal 83, trans_repo.find_all_by_result("success").count
  end

  def test_it_will_find_all_transactions_by_created_at
    assert_equal 2, trans_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_will_find_all_transactions_by_updated_at
    assert_equal 2, trans_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  end

  def test_invoice_method_will_return_invoice_id_associated_with_a_particular_transaction
    sales_engine = MiniTest::Mock.new
    repo = TransactionRepository.new(filename, sales_engine)
    invoice = Invoice.new({id: 10}, 'fake parent')
    sales_engine.expect(:transaction_invoice, invoice, [10])
    assert_equal invoice, repo.invoice(10)
    sales_engine.verify
  end
end
