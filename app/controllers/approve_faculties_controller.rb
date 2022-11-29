# frozen_string_literal: true

# Controller to Approve to Faculty Account
class ApproveFacultiesController < ApplicationController
  before_action :require_login
  def index
    # puts @current_user.id
    #puts current_user.account_type
    if @current_user.account_type != 'Department Chair'
      flash[:alert] = 'You must be a department chair to approve new accounts'
    end
    @approval_needed_accounts = Faculty.where(approved: false)
  end

  def update
    approved_account = Faculty.find(params[:id])
    approved_account.update(approved: true)
    redirect_to approve_faculties_path
  end
end
