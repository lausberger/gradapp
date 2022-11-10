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

end
