class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :load_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.order(:name).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @activities = @user.activities.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "controllers.categories.create_success"
      redirect_to new_user_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controllers.users.edit_success"
      redirect_to root_url
    else
      flash[:danger] = t "controllers.users.edit_error"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
