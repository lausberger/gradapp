require 'spec_helper'
require 'rails_helper'

describe Education do
  before(:each) do
    @sample_student = {
      first_name: 'Brandon',
      last_name: 'Egger',
      email: 'beggr@uiowa.edu',
      phone: '3196408865',
      dob: Date.new,
      status: 'submitted'
    }
    @sample_application = GraduateApplication.create(@sample_student)
    @sample_education = {
      school_name: 'University of Iowa',
      state_date: Date.parse('4-22-2019'),
      end_date: Date.new,
      currently_attending: false,
      degree: 'Bachelors',
      major: 'Computer Science',
      gpa: {
        numerator: 3.9,
        denomination: 4.0
      }
    }
  end
  describe 'creating an education object for an application' do
    context 'with all required fields' do
      it 'should create an education object for the associated application' do
        @sample_application.educations.build(@sample_education)
        expect(@sample_application.save).to be_truthy
      end
    end
    context 'with invalid start and end dates' do
      it 'should be invalid' do
        @sample_education[:start_date] = Date.parse('4-22-2019')
        @sample_education[:end_date] = Date.parse('4-21-2019')
        @sample_application.educations.build(@sample_education)
        expect(@sample_application.save).to be_falsey
      end
    end
    context 'with missing parameters' do
      it 'should be invalid' do
        @sample_application.educations.build
        expect(@sample_application.save).to be_falsey
      end
    end
  end
end
