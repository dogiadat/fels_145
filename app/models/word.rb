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
  scope :random, -> {order "RANDOM()"}

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: lambda {|attribute| attribute[:content].blank?}

  validates :content, presence: true, uniqueness: true,
    length: {maximum: 255}
  validate :check_answers

  def answer
    self.word_answers.where(is_correct: true).first
  end

  private
  def check_answers
    answers = self.word_answers.reject {|word_answer| word_answer.marked_for_destruction?}
    if answers.blank?
      self.errors.add :word_answers, I18n.t(".errors.answer_present")
    elsif answers.combination(2).any? {|a1, a2| a1.content == a2.content}
      self.errors.add :word_answers, I18n.t(".errors.same_answers")
    elsif answers.count {|answer| answer.is_correct?} != 1
      self.errors.add :word_answers, I18n.t(".errors.correct_only")
    end
  end
end
