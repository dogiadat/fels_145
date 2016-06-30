class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :admin_user
end
