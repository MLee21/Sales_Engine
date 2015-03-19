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

  def test_it_will_return_a_favorite_merchant
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    customer = sales_engine.customer_repo.customers[50]
    assert_equal "Rutherford, Bogan and Leannon", customer.favorite_merchant.name
  end
end