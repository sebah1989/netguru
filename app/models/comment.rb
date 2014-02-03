class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String
  field :abusive, type: Boolean, default: false

  belongs_to :user
  belongs_to :post
  has_many :votes, dependent: :destroy

  def check_abusive
    check_votes = votes.inject(0) {|sum, vote| sum += 1 if vote.value == -1}
    if check_votes && check_votes >= 3
      update_attributes({ abusive: true })
    end
  end

  def mark_as_not_abusive
    update_attributes({ abusive: false })
  end

  def vote_up(user_id)
    vote(user_id, 1)
  end

  def vote_down(user_id)
    vote(user_id, -1)
  end

  private
  def vote(user_id, value)
    unless votes.where({ user_id: user_id }).any?
      votes.create({ value: value, user_id: user_id })
    end
  end
end
