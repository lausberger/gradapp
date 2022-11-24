# frozen_string_literal: true

# Graduate application controller class for handling associated views for grad applications
class GraduateApplicationsController < ApplicationController
  def index
    @graduate_applications = GraduateApplication.all
  end

  def show
    id = params[:id]
    @graduate_application = GraduateApplication.find(id)
  end

  def new
    @graduate_application = GraduateApplication.new
    @graduate_application.educations.build
  end

  def create
    param_hash = graduate_application_params.to_hash
    param_hash[:status] = 'submitted'

    @graduate_application = GraduateApplication.create(param_hash)
    flash[:notice] = 'Graduate application was successfully submitted.' if @graduate_application.valid?
    flash[:notice] = 'Application submission failed, please retry.' unless @graduate_application.valid?
    @graduate_application.status = 'denied' unless @graduate_application.valid?
    if @graduate_application.valid?
      redirect_to graduate_applications_path
    else
      render 'new'
    end
  end

  private

  def graduate_application_params
    education_attr = %i[school_name degree major gpa_value gpa_scale currently_attending start_date end_date _destroy]
    params.require(:graduate_application).permit(:first_name, :last_name, :email, :phone, :dob, educations_attributes: education_attr)
  end
end
