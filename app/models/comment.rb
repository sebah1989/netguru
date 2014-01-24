class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  belongs_to :user
  belongs_to :post
  has_many :votes

  def abusive
    self.votes.inject(0){|sum, vote| sum +=1 if vote.value == -1} >= 3
  end
end
