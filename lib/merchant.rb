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
<<<<<<< HEAD
    @repo       = repo
=======
    @repo       = parent
>>>>>>> cb08f184069938553893913aa709220d57da3b6e
  end

  def items
    repo.find_items(id)
  end

  def invoices
    repo.find_invoices(id)
  end 
<<<<<<< HEAD
end

=======
end
>>>>>>> cb08f184069938553893913aa709220d57da3b6e
