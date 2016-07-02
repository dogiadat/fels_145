class LessonsController < ApplicationController
  before_action :load_lesson, only: [:show, :update]
  before_action :logged_in_user, only: [:create, :update]

  def show
    @words = @lesson.category.words
    if @lesson.is_completed?
      flash[:success] = t ".success.finish"
    else
      flash[:success] = t ".success.doing_lesson"
    end
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.category.words.any?
      if @lesson.save
        flash[:success] = t "views.lesson.success"
        redirect_to @lesson
      else
        flash[:danger] = t "views.lesson.fails"
        redirect_to categories_url
      end
    else
      flash[:danger] = t ".no_word_error"
      redirect_to categories_url
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      @lesson.update_attribute :is_completed, true
      flash[:success] = t ".success"
      redirect_to @lesson
    else
      flash[:failed] = t ".failed"
    end
  end

  private
  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    redirect_to categories_url if @lesson.nil?
  end

  def lesson_params
    params.require(:lesson).permit :user_id, :category_id,
      lesson_words_attributes: [:id, :word_id, :word_answer_id, :_destroy]
  end
end
