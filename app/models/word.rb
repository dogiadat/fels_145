class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  has_many :lesson_words

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: lambda {|attribute| attribute[:content].blank?}

  validates :content, presence: true, uniqueness: true,
    length: {maximum: 255}
end
