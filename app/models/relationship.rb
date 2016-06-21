class Relationship < ActiveRecord::Base
  belongs_to :followed, classname: "User"
  belongs_to :follower, classname: "User"
end
