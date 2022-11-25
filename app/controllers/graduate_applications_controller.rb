# frozen_string_literal: true

# Graduate application controller class for handling associated views for grad applications
class GraduateApplicationsController < ApplicationController
  before_action :parse_educations_form_data, only: [:create]

  def index
    @graduate_applications = GraduateApplication.all
  end

  def show
    id = params[:id]
    @graduate_application = GraduateApplication.find(id)
  end

  def new
    @graduate_application = GraduateApplication.new
  end

  def create
    @graduate_application = GraduateApplication.create(@graduate_application_params)
    flash[:notice] = 'Graduate application was successfully submitted.' if @graduate_application.valid?
    flash[:notice] = 'Application submission failed, please retry.' unless @graduate_application.valid?
    @graduate_application.status = 'denied' unless @graduate_application.valid?

    puts @graduate_application.errors.full_messages

    if @graduate_application.valid?
      redirect_to graduate_applications_path
    else
      render 'new'
    end
  end

  private

  def parse_educations_form_data
    @graduate_application_params = graduate_application_params.to_hash
    @graduate_application_params[:status] = 'submitted'

    return unless @graduate_application_params.key?('educations_attributes')

    @graduate_application_params['educations_attributes'].each do |key, _value|
      is_attending = @graduate_application_params['educations_attributes'][key]['currently_attending'] == '1'
      @graduate_application_params['educations_attributes'][key]['currently_attending'] = is_attending
    end
  end

  def graduate_application_params
    education_attr = %i[id school_name degree major gpa_value gpa_scale currently_attending start_date end_date _destroy]
    params.require(:graduate_application).permit(:first_name, :last_name, :email, :phone, :dob, educations_attributes: education_attr)
  end
end
