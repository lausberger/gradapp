# frozen_string_literal: true

# Controller to Approve to Faculty Account
class ApproveApplicationsController < ApplicationController
  before_action :require_login

  def index
    acc = Account.find_by(id: @current_user)
    if acc.account_type != 'Department Chair'
      flash[:alert] = 'You must be a department chair to make decisions on graduate applications'
    end
    @applications = GraduateApplication.where(status: 'submitted')
  end

  def update
    status = params[:commit].downcase
    application_id = params[:id]
    application = GraduateApplication.find(application_id)
    case status
    when 'approve'
      application.update(status: 'accepted')
    when 'deny'
      application.update(status: 'denied')
    else
      application.update(status: 'submitted')
    end
    redirect_to approve_applications_path
  end
end
