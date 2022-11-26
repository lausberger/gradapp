# frozen_string_literal: true

# Main controller for account model
class AccountsController < ApplicationController
  before_action :validate_account_params, only: [:create]

  def new; end

  def show
    (flash.now[:warning] = 'You must be logged in to view your profile') and (render :new) if session[:user_id].nil?
  end

  def create
    @account = Account.new(registration_params)
    if Account.where(email: @account.email)
      flash[:warning] = 'An account with that email already exists'
    end
    if @account.save
      flash[:notice] = 'Account registration successful'
      redirect_to root_path and return
    else
      flash[:alert] = 'Account registration failed, please try again.'
    end
    render :new # Account validation failed
  end

  private

  def registration_params
    params.require(:account).permit(:first_name, :last_name, :email, :password, :password_confirmation, :type)
  end

  def validate_account_params
    valid = true
    account_params = registration_params
    (flash[:warning] = 'Fields cannot be empty') and (valid = false) if account_params.any? { |_k, v| v.blank? }
    (flash[:warning] = 'Passwords do not match') and (valid = false) if account_params[:password] != account_params[:password_confirmation]
    (flash[:warning] = 'Please enter a valid email address') and (valid = false) if account_params[:email] !~
                                                                                    /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    render :new unless valid # Account validation failed
  end
end
