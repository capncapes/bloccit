class Comment < ApplicationRecord
  belongs_to :post
  
  def my_name
      "Brandon"
  end
end
