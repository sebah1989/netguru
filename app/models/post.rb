class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title
  
  has_many :comments
  belongs_to :user

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def hotness
    passed_time = (Time.now - self.created_at.to_time)/86400.0
    at_least_3_comments = self.comments.count >= 3
    
    if passed_time <= 1
      return 4 if at_least_3_comments
      3
    elsif passed_time > 1 && passed_time <= 3
      return 3 if at_least_3_comments
      2
    elsif passed_time > 3 && passed_time <= 7
      return 2 if at_least_3_comments
      1
    else
      return 1 if at_least_3_comments
      0
    end  
  end
end
