class Comment
  include Mongoid::Document

  field :body, type: String
  
  belongs_to :user
  belongs_to :post
  has_many :votes
  
end
