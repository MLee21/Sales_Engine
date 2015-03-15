require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < MiniTest::Test

  attr_accessor :filename
  attr_reader :engine, :customer_repo

  def setup
    @filename = '../test/data/customers.csv'
    @engine = SalesEngine.new(filename)
    @customer_repo = CustomerRepository.parse(filename, engine)
  end

  def test_it_will_know_its_parent
    assert_equal engine, customer_repo.parent
  end

  def test_it_will_return_all_of_the_customer_objects
    assert_equal 99, customer_repo.all.count
  end

  def test_it_will_find_customers_by_id
    assert_equal 1, customer_repo.find_customers_by_id(1).id
  end

  def test_it_will_find_customers_by_first_name
    assert_equal "Leanne", customer_repo.find_customers_by_first_name("Leanne").first_name
  end

  def test_it_will_find_customers_by_last_name
    assert_equal "Daugherty", customer_repo.find_customers_by_last_name("Daugherty").last_name
  end

  def test_it_will_find_customers_by_created_at
    assert_equal "2012-03-27 14:54:09 UTC", customer_repo.find_customers_by_created_at("2012-03-27 14:54:09 UTC").created_at
  end

  def test_it_will_find_customers_by_updated_at
    assert_equal "2012-03-27 14:54:10 UTC", customer_repo.find_customers_by_updated_at("2012-03-27 14:54:10 UTC").updated_at
  end

  def test_it_will_find_all_customers_by_id
    assert_equal 1, customer_repo.find_all_customers_by_id(1).count
  end

  def test_it_will_find_all_customers_by_first_name
    assert_equal 1, customer_repo.find_all_customers_by_first_name("Ramona").count
  end

  def test_it_will_find_all_customers_by_last_name
    assert_equal 1, customer_repo.find_all_customers_by_last_name("Reynolds").count
  end

  def test_it_will_find_all_customers_by_created_at
    assert_equal 3, customer_repo.find_all_customers_by_created_at("2012-03-27 14:54:11 UTC").count
  end

  def test_it_will_find_all_customers_by_updated_at
    assert_equal 3, customer_repo.find_all_customers_by_updated_at("2012-03-27 14:54:11 UTC").count
  end
end
