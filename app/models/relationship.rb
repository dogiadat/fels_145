class Relationship < ActiveRecord::Base

  belongs_to :followed, classname: "User"
  belongs_to :follower, classname: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
