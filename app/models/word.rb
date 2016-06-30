class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  has_many :lesson_words
  has_many :lessons, through: :lesson_words

  scope :all_word, ->(user_id){}
  scope :learned, ->(user_id){joins(:lessons)
    .distinct.where(lessons: {is_completed: true, user_id: user_id})}
  scope :not_learned, ->(user_id){where.not id: Word.learned(user_id)}
  scope :by_category, ->(category_id) do
    where category_id: category_id if category_id.present?
  end

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: lambda {|attribute| attribute[:content].blank?}

  validates :content, presence: true, uniqueness: true,
    length: {maximum: 255}
end
