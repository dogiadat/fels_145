class Relationship < ActiveRecord::Base

  belongs_to :followed, class_name: User.name
  belongs_to :follower, class_name: User.name

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_destroy :create_activity_unfollow


  private
  def create_activity_follow
    follower = User.find_by id: self.follower_id
    follower.create_activity self.followed_id, Settings.activity_type.follow
  end

  def create_activity_unfollow
    byebug
  end
end
