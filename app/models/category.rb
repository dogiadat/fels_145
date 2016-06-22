class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  validates :name, presence: true, length: {maximum: 150}
end
