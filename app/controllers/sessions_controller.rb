# frozen_string_literal: true

# Controller for login sessions
class SessionsController < ApplicationController
  before_action :validate_login_params, only: [:create]

  def new; end

  def create
    user = Account.find_by(email: params[:session][:email].downcase)
    if user.present? && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.first_name}."
      redirect_to root_path
    else
      flash.now[:warning] = "Email or password is incorrect"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been signed out successfully."
    redirect_to root_path
  end

  def login_params
    params.require(:session).permit(:email, :password, :user_id)
  end

  def validate_login_params
    login = login_params
    (flash[:warning] = 'Email field cannot be empty') and (render :new and return) if login[:email].blank?
    (flash[:warning] = 'Password field cannot be empty') and (render :new and return) if login[:password].blank?
    (flash[:warning] = 'Please provide a valid email address') and (render :new and return) if login[:email] !~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end
end