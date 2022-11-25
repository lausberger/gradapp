# frozen_string_literal: true

describe GraduateApplicationsController do
  describe 'submitting a graduate application' do
    before(:each) do
      @sample_application = {
        first_name: 'John',
        last_name: 'Doe',
        email: 'johndoe@uiowa.edu',
        phone: '14118839251',
        dob: Date.new,
        educations_attributes: {
          '0': {
            school_name: 'University of Iowa',
            degree: 'bachelor',
            major: 'Computer Science',
            gpa_value: 3.90,
            gpa_scale: 4.00,
            currently_attending: '1',
            start_date: Date.parse('1-2-2019'),
            end_date: Date.parse('1-2-2022')
          }
        }
      }
    end
    context 'with a valid request' do
      it 'should flash the application was successful' do
        post :create, graduate_application: @sample_application
        expect(flash[:notice]).to match(/Graduate application was successfully submitted./)
      end
      it 'should return http response created' do
        post :create, graduate_application: @sample_application
        expect(response).to have_http_status(:found)
      end
    end
    context 'with a GPA that exceeds the scale' do
      it 'should flash the request is invalid' do
        puts @sample_application
        @sample_application[:educations_attributes][:'0'][:gpa_value] = 5.0
        post :create, graduate_application: @sample_application
        expect(flash[:notice]).to match(/Application submission failed, please retry./)
      end
    end
    context 'with an invalid email' do
      it 'should flash the request was invalid' do
        @sample_application[:email] = 'email with no domain'
        post :create, graduate_application: @sample_application
        expect(flash[:notice]).to match(/Application submission failed, please retry./)
      end
    end
    context 'with an invalid phone number' do
      it 'should flash the request was invalid' do
        @sample_application[:email] = 'phone'
        post :create, graduate_application: @sample_application
        expect(flash[:notice]).to match(/Application submission failed, please retry./)

        @sample_application[:email] = '319492451222'
        post :create, graduate_application: @sample_application
        expect(flash[:notice]).to match(/Application submission failed, please retry./)
      end
    end
    context 'with missing required fields' do
      it 'should flash the request was invalid' do
        post :create, graduate_application: @sample_application.except!(:email)
        expect(flash[:notice]).to match(/Application submission failed, please retry./)
      end
    end
    context 'with no education attributes' do
      it 'should flash the application was successful' do
        @sample_application.delete(:educations_attributes)
        post :create, graduate_application: @sample_application
        expect(flash[:notice]).to match(/Graduate application was successfully submitted./)
      end
    end
  end
end
