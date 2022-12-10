# frozen_string_literal: true

# Controller for creating application evaluations for an application
class ApplicationEvaluationsController < ApplicationController
  before_action :require_login
  before_action :check_if_application_exists, only: %i[create update]

  def create
    Rails.logger.debug params.to_hash
  end

  def update
    # TODO: complete update route
  end

  private

  def check_if_application_exists
    unless params.key?('application_evaluation') && params[:application_evaluation].key?('graduate_application_id')
      flash[:notice] = 'Unable to find the application with that ID'
      redirect_to graduate_application_path
      return
    end

    @graduate_application = GraduateApplication.find(params[:application_evaluation][:graduate_application_id])
    return unless @graduate_application.nil?

    flash[:notice] = 'Unable to find the application with that ID'
    redirect_to graduate_application_path
  end

  def graduate_application_params
    params.require(:application_evaluation).permit(:score, :comment, :graduate_application_id)
  end
end
