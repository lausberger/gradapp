
describe GraduateApplication do
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :eye_color, :dob, address: [:street_address, :city, :state, :zip])
  end
end
