class WordsController < ApplicationController
  before_action :logged_in_user, :load_category, :user_admin,
    except: [:index]
  before_action :load_word, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t ".success"
      redirect_to @category
    else
      flash[:danger] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @word.lesson_words.any?
      flash[:danger] = t ".failed"
    else
      @word.destroy
      flash[:success] = t ".success"
    end
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

  def load_word
    @word = Word.find_by id: params[:id]
  end
end
