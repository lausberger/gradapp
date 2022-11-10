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
    gpa_out_of = graduate_application_params["gpa_out_of"]
    formatted_application = graduate_application_params.except("gpa_out_of")
    formatted_application["gpa"] = {
      :numerator => graduate_application_params["gpa"].to_f,
      :denominator => gpa_out_of.to_f,
    }
    formatted_application[:status] = "submitted"

    puts formatted_application
    @graduate_application = GraduateApplication.create!(formatted_application)
    flash[:notice] = "Graduate application was successfully submitted." if @graduate_application.valid?
    flash[:notice] = "Application submission failed, please retry." unless @graduate_application.valid?
    @graduate_application.status = "denied" unless @graduate_application.valid?

    redirect_to graduate_applications_path
  end

end
