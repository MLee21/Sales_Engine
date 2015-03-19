require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/customer'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'bigdecimal/util'

class CustomerTest < MiniTest::Test

  attr_reader :filename, :customer_repository, :engine

   def setup
    directory = './test/data'
    @filename = "#{directory}/customers.csv"
    @engine = SalesEngine.new(directory)
    @engine.startup
    @customer_repository = CustomerRepository.load_csvs(filename, engine)
  end

  def test_it_will_return_a_favorite_merchant
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    customer = sales_engine.customer_repository.customers[50]
    assert_equal "Rutherford, Bogan and Leannon", customer.favorite_merchant.name
  end

  def test_customer_knows_its_parent
    assert_equal customer_repository, customer_repository.customers.first.repo
  end

  def test_it_has_attributes_associated_with_the_customer
    customer = Customer.new(
      { id: 14,
      first_name: 'Joe', 
      last_name: 'Schmoe',
      created_at: 'Thr Mar 19 01:01:01 MDT 2015',
      updated_at: 'Thr Mar 19 01:01:01 MDT 2015',
      },
      'fakerepo')
    assert_equal 14, customer.id
    assert_equal 'Joe', customer.first_name
    assert_equal 'Schmoe', customer.last_name
    assert_equal 'Thr Mar 19 01:01:01 MDT 2015', customer.created_at
    assert_equal 'Thr Mar 19 01:01:01 MDT 2015', customer.updated_at
  end

  def test_the_repo_will_find_invoices
    repo = MiniTest::Mock.new
    customer = Customer.new({},repo)
    repo.expect(:find_invoices, [1], [0])
    assert_equal [1], customer.invoices
    repo.verify
  end

  def test_transactions_for_customer
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    assert_equal 4, sales_engine.customer_repository.customers[2].transactions.size
  end

  def test_customer_invoices_for_customer
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    assert_equal 4, sales_engine.customer_repository.customers[2].customer_invoices.size
  end
    
end