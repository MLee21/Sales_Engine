require_relative 'parser'
require 'pry'

class MerchantRepository

  attr_reader :merchants,
              :filename,
              :parent

  def self.parse(filename,parent)
    parser = Parser.new(filename,parent)
    merchants = parser.parse 
    new(merchants)    
  end

  def initialize(merchants,parent) 
    @merchants = merchants
    @parent = parent 
  end

  def all
    merchants
  end

  def random
    customers.sample
  end

  def find_by_id(number)
    customers.find {|customer| customer.id == number }
  end

  def find_by_name(name)
    # fill out
  end
end

# merchant_repo = MerchantRepository.new('../test/data/merchants.csv')
# merchant_repo.all