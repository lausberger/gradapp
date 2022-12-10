# frozen_string_literal: true

# Controller for creating application evaluations for an application
class ApplicationEvaluationsController < ApplicationController
  before_action :require_login
  before_action :check_if_application_exists, :format_params, only: %i[create update]

  def create
    unless params.key?('application_evaluation')
      flash[:warning] = 'Application evaluation creation failed'
      redirect_to graduate_application_path(@graduate_application)
    end

    @graduate_application.application_evaluations.create(params[:application_evaluation].to_hash)
    flash[:warning] = 'Application evaluation creation failed' unless @graduate_application.valid?

    redirect_to graduate_application_path(@graduate_application)
  end

  def update
    # TODO: complete update route
  end

  private

  def format_params
    return unless params.key?('application_evaluation') && params[:application_evaluation].key?('score')
    return unless params[:application_evaluation][:score].respond_to? :to_i

    params[:application_evaluation][:score] = params[:application_evaluation][:score].to_i
  end

  def check_if_application_exists
    unless params.key?('application_evaluation') && params[:application_evaluation].key?('graduate_application_id')
      flash[:warning] = 'Unable to find the application with that ID'
      redirect_to graduate_applications_path
      return
    end

    @graduate_application = GraduateApplication.find(params[:application_evaluation][:graduate_application_id])
    params[:application_evaluation].delete(:graduate_application_id)
    return unless @graduate_application.nil?

    flash[:warning] = 'Unable to find the application with that ID'
    redirect_to graduate_applications_path
  end

  def application_evaluation_params
    params.require(:application_evaluation).permit(:score, :comment, :graduate_application_id)
  end
end
