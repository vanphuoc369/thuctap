class LoginsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:login][:email].downcase)
    if user && user.authenticate(params[:login][:password])
      if user.activated?
        log_in user
        remember_status user
        redirect_back_or user
      else
        message  = "Tài khoản chưa được kích hoạt. "
        message += "Kiểm tra email để kích hoạt tài khoản."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Đăng nhập không thành công"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def remember_status user
    params[:login][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
