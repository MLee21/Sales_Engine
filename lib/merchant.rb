require 'pry'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repo

  def initialize(data, repo)
    @id         = data[:id].to_i 
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo       = repo
  end

  def items
    repo.find_items(id)
  end

  def invoices
    repo.find_invoices(id)
  end 
end
