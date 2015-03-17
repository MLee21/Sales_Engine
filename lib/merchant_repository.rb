require_relative 'parser'
require_relative 'merchant'
require 'pry'

class MerchantRepository

  attr_reader :merchants,
              :filename,
              # :repo,  ## ran rake spec without this variable and still ran after changing parse method
              ## not sure if it's necessary for rest of repo. don't delete until sure.
              :sales_engine

  def self.load_csvs(filename, sales_engine)
    repo      = self.allocate()
    parser    = Parser.new(filename)
    merchants = parser.parse.map do |merchant|
      Merchant.new(merchant, repo)
    end
    repo.send(:initialize, merchants, sales_engine)
    repo
  end

  def initialize(merchants, sales_engine)
    @merchants = merchants
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(number)
    merchants.find {|merchant| merchant.id == number }
  end

  def find_by_name(name)
    merchants.find {|merchant| merchant.name == name }
  end

  def find_by_created_at(date)
    merchants.find {|merchant| merchant.created_at == date }
  end

  def find_by_updated_at(date)
    merchants.find {|merchant| merchant.updated_at == date }
  end

  def find_all_by_id(number)
    merchants.find_all {|merchant| merchant.id == number }
  end

  def find_all_by_name(name)
    merchants.find_all {|merchant| merchant.name == name }
  end

  def find_all_by_created_at(date)
    merchants.find_all {|merchant| merchant.created_at == date }
  end

  def find_all_by_updated_at(date)
    merchants.find_all {|merchant| merchant.updated_at == date }
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end
end
