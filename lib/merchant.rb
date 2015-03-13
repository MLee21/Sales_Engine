class Merchant

<<<<<<< HEAD
  attr_reader :id,
              :name,
              :created_at,
              :updated_at
=======
  attr_reader  :id,
               :name,
               :created_at,
               :updated_at
>>>>>>> 0c93f776da0f29c552dada3b95614146395ba864

  def initialize(data, parent)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo       = parent
  end

  
end