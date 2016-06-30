class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:destroy]

  def index
    @users = User.order(:name).paginate page: params[:page], per_page: Settings.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to admin_users_url
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
