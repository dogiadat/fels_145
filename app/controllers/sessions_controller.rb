class SessionsController < ApplicationController

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      @current_user = user
      flash[:success] = t "controllers.session.success"
      if user.is_admin?
        redirect_to admin_root_url
      else
        redirect_to root_url
      end
    else
      flash[:danger] = t "controllers.session.error"
      render :new
    end
  end

  def destroy
    session.delete :user_id
    @current_user = nil
    redirect_to root_url
  end
end
