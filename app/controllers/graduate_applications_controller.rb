class GraduateApplicationsController < ApplicationController
  def graduate_application_params
    params.require(:graduate_application).permit(:first_name, :last_name, :email, :phone, :dob, :gpa_value, :gpa_scale)
  end

  def show
    id = params[:id]
    @graduate_application = GraduateApplication.find(id)
  end

  def index
    @graduate_applications = GraduateApplication.all
  end

  def new
    # Navigates to new view
  end

  def create
    param_hash =graduate_application_params.to_hash
    param_hash[:status] = "submitted"

    @graduate_application = GraduateApplication.create!(param_hash)
    flash[:notice] = "Graduate application was successfully submitted." if @graduate_application.valid?
    flash[:notice] = "Application submission failed, please retry." unless @graduate_application.valid?
    @graduate_application.status = "denied" unless @graduate_application.valid?

    redirect_to graduate_applications_path
  end

end
