class Lesson < ActiveRecord::Base
  include ActivitiesHelper

  belongs_to :category
  belongs_to :user
  has_many :lesson_words
  has_many :words, through: :lesson_words
  has_many :word_answers, through: :lesson_words

  accepts_nested_attributes_for :lesson_words,
    reject_if: lambda {|attribute| attribute[:word_id].blank?}, allow_destroy: true

  before_create :random_words
  after_create :create_activity_start_lesson
  after_update :create_activity_finish_lesson

  private
  def random_words
    self.words = if category.words.size >= Settings.word_size
      category.words.random.limit Settings.word_size
    else
      category.words.random
    end
  end

  def create_activity_start_lesson
    create_activity self.user_id, self.id, :start_lesson
  end

  def create_activity_finish_lesson
    create_activity self.user_id, self.id, :finish_lesson
  end
end
