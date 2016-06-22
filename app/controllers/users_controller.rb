class UsersController < ApplicationController

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "views.users.create.success"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
