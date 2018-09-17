class UsersController < ApplicationController
   # GET signup (rendering page)
  def new
  end

  def create
    user = User.new(user_params)
    lower_case_email = user.email.strip.downcase
    user.email = lower_case_email
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end