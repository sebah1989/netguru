class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String
  field :abusive, type: Boolean, default: false

  belongs_to :user
  belongs_to :post
  has_many :votes

  def check_abusive
    votes = self.votes.inject(0) {|sum, vote| sum += 1 if vote.value == -1}
    if votes && votes >= 3
      update_attributes({ abusive: true })
    end
  end

  def mark_as_not_abusive
    update_attributes({ abusive: false })
  end

  def vote_up(user_id)
    if votes.where({ user_id: user_id }).count == 0
      votes.create({ value: 1, user_id: user_id })
    end
  end
end
