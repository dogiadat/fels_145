class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = I18n.t "controllers.categories.create_success"
      redirect_to root_url
    else
      render :new
    end
  end

  private
    def category_params
      params.require(:category).permit :name
    end
end
