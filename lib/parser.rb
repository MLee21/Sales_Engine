require 'csv'
require 'pry'

 class Parser

  attr_reader :file
          
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end
  
  def initialize(filename)
    @file = CSV.open(filename, headers: true, header_converters: :symbol, converters: [:all, :blank_to_nil])
   end

  def parse
   @file.to_a.map {|row| row.to_hash }  
   end
end

# parser = Parser.new('../test/data/merchants.csv')
# puts parser.parse[0[0]][:id]


