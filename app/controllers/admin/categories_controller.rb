class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: [:new, :create, :index]

  def index
    @categories = Category.order(:name).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controllers.categories.create_success"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "controllers.categories.updated"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "views.categories.delete_category"
    else
      flash[:danger] = t "controllers.categories.erro2"
    end
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
