
describe GraduateApplicationsController do
  describe 'submitting a graduate application' do
    before(:each) {
      @sample_application = {
        :first_name => "John",
        :last_name => "Doe",
        :email => "johndoe@uiowa.edu",
        :phone => "14118839251",
        :dob => Date.new,
        :gpa_value => "3.4",
        :gpa_scale => "4.0",
      }
    }
    context 'with a valid request' do
      it 'should flash the application was successful' do
        post :create, :graduate_application => @sample_application
        expect(flash[:notice]).to match /Graduate application was successfully submitted./
      end
      it 'should return http response created' do
        post :create, :graduate_application => @sample_application
        expect(response).to have_http_status(:found)
      end
    end
    context 'with a GPA that exceeds the scale' do
      it 'should flash the request is invalid' do
        @sample_application[:gpa_value] = 5.0
        post :create, :graduate_application => @sample_application
        expect(flash[:notice]).to match /Application submission failed, please retry./
      end
    end
    context 'with an invalid email' do
      it 'should flash the request was invalid' do
        @sample_application[:email] = "email with no domain"
        post :create, :graduate_application => @sample_application
        expect(flash[:notice]).to match /Application submission failed, please retry./
      end
    end
    context 'with an invalid phone number' do
      it 'should flash the request was invalid' do
        @sample_application[:email] = "phone"
        post :create, :graduate_application => @sample_application
        expect(flash[:notice]).to match /Application submission failed, please retry./

        @sample_application[:email] = "319492451222"
        post :create, :graduate_application => @sample_application
        expect(flash[:notice]).to match /Application submission failed, please retry./
      end
    end
    context 'with missing required fields' do
      it 'should flash the request was invalid' do
        post :create, :graduate_application => @sample_application.except!(:gpa_scale)
        expect(flash[:notice]).to match /Application submission failed, please retry./
      end
    end
  end
end

