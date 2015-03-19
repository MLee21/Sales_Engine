require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/parser'
require 'bigdecimal'
require 'bigdecimal/util'

class MerchantTest < MiniTest::Test

  attr_reader :filename, :merchant_repository, :engine, :merchants

  def setup
    directory = './test/data'
    @filename = "#{directory}/merchants.csv"
    @engine = SalesEngine.new(directory)
    @engine.startup
    @merchant_repository = MerchantRepository.load_csvs(filename, engine)
  end

  def test_it_exists
    assert Merchant
  end

  def test_it_knows_its_parent
    assert_equal merchant_repository, merchant_repository.merchants.first.repo
  end

  def test_it_has_attributes_associated_with_the_merchant
    merchant = Merchant.new(
      { id: 12,
        name: 'Josh',
        created_at: 'Wed Mar 18 07:35:06 MDT 2015',
        updated_at: 'Thr Mar 19 01:01:01 MDT 2015'
      },
      'fake repository'
    )
    assert_equal 12, merchant.id
    assert_equal "Josh", merchant.name
    assert_equal 'Wed Mar 18 07:35:06 MDT 2015', merchant.created_at
    assert_equal 'Thr Mar 19 01:01:01 MDT 2015', merchant.updated_at
  end

  def test_repo_finds_items_for_merchant
    repo = Minitest::Mock.new
    merchant = Merchant.new({},repo)
    repo.expect(:find_items, [1], [0])
    assert_equal [1], merchant.items
    repo.verify
  end

  def test_repo_finds_invoices_for_merchant
    repo = MiniTest::Mock.new
    merchant = Merchant.new({},repo)
    repo.expect(:find_invoices,[1],[0])
    assert_equal [1], merchant.invoices
    repo.verify
  end

  def test_find_invoices_through_successful_transactions
    merchant = Merchant.new({:id=>1},merchant_repository)
    invoice_ids = merchant.successful_invoices.map do |invoice|
      invoice.id
    end
    assert_equal [29], invoice_ids
  end

   def working_test_data
    {
      created_at: "2012-03-25 09:54:09 UTC",
    }
  end

  # def test_it_can_calculate_revenue
  #   merchant = Merchant.new(working_test_data,merchant_repository)
  #   invoice1 = MiniTest::Mock.new(created_at: '1-01-2015')
  #   invoice1.expect(:revenue, 120.50)
  #   invoice2 = MiniTest::Mock.new(created_at: '1-01-2015')
  #   invoice2.expect(:revenue, 0.50)
  #   invoices = [invoice1,invoice2]
  #   merchant.stub :successful_invoices, invoices do
  #     assert_equal 121.00, merchant.revenue(invoices)
  #   end
  # end

  class FakeSalesEngine < SalesEngine
    def initialize
      # noop
    end
    attr_accessor :invoice_repository
    attr_accessor :transaction_repository
    attr_accessor :invoice_item_repository
    attr_accessor :merchant_repository
  end


  class MockMerchantRepo
    attr_accessor :to_find, :found_by

    def initialize(to_find)
      @to_find = to_find
    end

    def find_invoices(id)
      @found_by = id
      @to_find
    end
  end

  class MockInvoice
    attr_reader :created_at, :revenue

    def initialize(options)
      @created_at = options.fetch :created_at
      @successful = options.fetch :successful
      @revenue    = options.fetch :revenue
    end

    def successful?
      @successful
    end
  end


  def test_it_will_return_successful_invoices_by_date
    merchant_repo = MockMerchantRepo.new([
      MockInvoice.new(created_at: '1-01-2015', successful: true,  revenue: 1),
      MockInvoice.new(created_at: '1-01-2015', successful: false, revenue: 1000),
      MockInvoice.new(created_at: '1-02-2015', successful: true,  revenue: 2),
      MockInvoice.new(created_at: '1-02-2015', successful: true,  revenue: 3),
    ])
    merchant = Merchant.new({id: 12}, merchant_repo)

    assert_equal 1,  merchant.revenue('1-01-2015')
    assert_equal 5,  merchant.revenue('1-02-2015')
    assert_equal 12, merchant_repo.found_by
  end

  # class ::BigDecimal
  #   def inspect
  #     sprintf "%f(bd)", to_f
  #   end
  # end

end
