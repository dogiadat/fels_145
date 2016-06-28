class WordsController < ApplicationController
  before_action :logged_in_user, :user_admin
  before_action :load_category, only: [:new, :create, :destroy]

  def new
    @word = @category.words.new
    @word.word_answers.new
  end

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t ".success"
      redirect_to @category
    else
      flash[:danger] = t "controllers.words.create.fail"
      render :new
    end
  end

  def destroy
    Word.find_by(id: params[:id]).destroy
    redirect_to @category
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
  end

  def word_params
    params.require(:word).permit :content,
      word_answers_attributes: [:content, :is_correct, :_destroy]
  end
end
