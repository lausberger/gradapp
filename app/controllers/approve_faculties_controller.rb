# frozen_string_literal: true

# Controller to Approve to Faculty Account
class ApproveFacultiesController < ApplicationController
  def index
    @approval_needed_accounts = Faculty.where(approved: false)
  end

  def update
    approved_account = Faculty.find(params[:id])
    approved_account.update(approved: true)
    redirect_to approve_faculties_path
  end
end
