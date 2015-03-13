class SalesEngine

  attr_reader :data

  def initialize
    # (data = './data')
    @data = data
  end

  def startup
    merchant_repository
  end

  def merchant_repository
    @merchant_repository = MerchantRepository.new("path/to/csv", self)
  end










end