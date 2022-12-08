# frozen_string_literal: true

# Controller to Approve to Faculty Account
class ApproveFacultiesController < ApplicationController
  before_action :require_login
  
  def index
    if current_user.account_type != 'Department Chair'
      flash[:alert] = 'You do not have permission to perform this action'
      redirect_to home_path and return
    end
    @approval_needed_accounts = Faculty.where(approved: false)
  end

  def update
    approved_account = Faculty.find(params[:id])
    approved_account.update(approved: true)
    redirect_to approve_faculties_path
  end
end
