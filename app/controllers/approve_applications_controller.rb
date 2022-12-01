# frozen_string_literal: true

# Controller to Approve to Faculty Account
class ApproveApplicationsController < ApplicationController
  before_action :require_login

  def index
    acc = Account.find_by(id: @current_user)
    if acc.account_type != 'Department Chair'
      flash[:alert] = 'You must be a department chair to make decisions on graduate applications'
    end
    @application = GraduateApplication.where(status: 'submitted')
  end

  def update
    approved_application = GraduateApplication.find(params[:approve])
    denied_application = GraduateApplication.find(params[:deny])
    approved_application&.update(status: 'approved')
    denied_application&.update(status: 'denied')
  end
end
