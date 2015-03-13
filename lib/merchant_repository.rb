require_relative 'parser'
require_relative 'merchant'
require 'pry'

class MerchantRepository

  attr_reader :merchants,
              :filename,
              :repo,
              :parent

  def self.parse(filename, repo)
    parser = Parser.new(filename)
    merchants = parser.parse 
    new(merchants.map {|h| Merchant.new(h,self) }, repo)    
  end

  def initialize(merchants, parent) 
    @merchants = merchants
    @parent = parent
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

end
