require 'csv'
require 'pry'

 class Parser

  attr_reader :file, :parent
          
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end
  
  def initialize(filename)
    @file = CSV.open(filename, headers: true, header_converters: :symbol, converters: [:all, :blank_to_nil])
  end

  def parse
<<<<<<< HEAD
   @file.to_a.map {|row| row.to_hash }  
=======
    @file.to_a.map {|row| row.to_hash }  
>>>>>>> 0c93f776da0f29c552dada3b95614146395ba864
  end
end

# parser = Parser.new('../test/data/merchants.csv')
# puts parser.parse[0[0]][:id]


