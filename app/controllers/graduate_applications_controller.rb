class GraduateApplicationsController < ApplicationController
  def graduate_application_params
    params.require(:graduate_application).permit(:first_name, :last_name, :email, :phone, :dob, :gpa, :gpa_out_of)
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
    @graduate_application = GraduateApplication.create!(graduate_application_params)
    flash[:notice] = "Graduate application was successfully submitted." if @graduate_application.valid?
    flash[:notice] = "Application submission failed, please retry." unless @graduate_application.valid?
    @graduate_application.status = "denied" unless @graduate_application.valid?

    redirect_to graduate_applications_path
  end

end
