class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Integer

  belongs_to :user
  belongs_to :comment
end
