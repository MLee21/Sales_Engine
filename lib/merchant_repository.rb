require_relative 'parser'
require_relative 'merchant'
<<<<<<< HEAD
require 'pry'
=======
>>>>>>> 0c93f776da0f29c552dada3b95614146395ba864

class MerchantRepository

  attr_reader :merchants,
              :filename,
<<<<<<< HEAD
              :repo,
              :parent
=======
              :repo
>>>>>>> 0c93f776da0f29c552dada3b95614146395ba864

  def self.parse(filename, repo)
    parser = Parser.new(filename)
    merchants = parser.parse 
    new(merchants.map {|h| Merchant.new(h,self) }, repo)    
  end

<<<<<<< HEAD
  def initialize(merchants, parent) 
    @merchants = merchants
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
=======
  def initialize(merchants, repo) 
    @merchants = merchants
    @repo = repo
>>>>>>> 0c93f776da0f29c552dada3b95614146395ba864
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
<<<<<<< HEAD
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
=======
    # fill out
>>>>>>> 0c93f776da0f29c552dada3b95614146395ba864
  end

<<<<<<< HEAD
end
=======
# merchant_repo = MerchantRepository.parse('../test/data/merchants.csv', "parent")
# puts merchant_repo.all
>>>>>>> 0c93f776da0f29c552dada3b95614146395ba864
