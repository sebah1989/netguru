class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  
  field :body, type: String
  field :abusive, type: Boolean, default: false


  belongs_to :user
  belongs_to :post
  has_many :votes

  def check_abusive
    votes = self.votes.inject(0) {|sum, vote| sum +=1 if vote.value == -1}
    if votes && votes >= 3
      self.abusive = true
      self.save
    end
  end
end
