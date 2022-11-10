class GraduateApplicationsController < ApplicationController
  def graduate_application_params
    params.require(:graduate_application).permit(:first_name, :last_name, :email, :phone, :dob, :gpa, :gpa_out_of)
  end

end
