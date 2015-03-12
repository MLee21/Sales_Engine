require_relative 'parser'
require_relative 'merchant'

class MerchantRepository

  attr_reader :merchants,
              :filename,
              :repo

  def self.parse(filename, repo)
    parser = Parser.new(filename)
    merchants = parser.parse 
    new(merchants.map {|h| Merchant.new(h,self) }, repo)    
  end

  def initialize(merchants, repo) 
    @merchants = merchants
    @repo = repo
  end

  # def raw_merchants
  #   @raw_merchants ||= Parser.new(filename, parent).parse
  # end

  def all
    @merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(number)
    merchants.find {|merchant| merchant.id == number }
  end

  def find_by_name(name)
    # fill out
  end
end

# merchant_repo = MerchantRepository.parse('../test/data/merchants.csv', "parent")
# puts merchant_repo.all