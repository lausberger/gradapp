# frozen_string_literal: true

# Controller for login sessions
class SessionsController < ApplicationController
  def new; end

  def create
    user = Account.find_by(email: params[:session][:email].downcase)
    if user.present? && user.authenticate(params[:session][:password])
      session[:user_id] = account.id
      flash[:notice] = "Welcome, #{account.first_name}!"
      redirect_to home_page
    else
      flash.now[:alert] = "Login unsuccessful. Please make sure your email and password are correct."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been signed out successfully."
    redirect_to root_path
  end
end