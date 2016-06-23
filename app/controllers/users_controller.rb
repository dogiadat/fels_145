class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  before_action :load_user, only: [:show, :destroy]
  before_action :user_admin, only: [:destroy]

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
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
