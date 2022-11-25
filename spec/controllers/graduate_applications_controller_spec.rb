# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

if RUBY_VERSION >= '2.6.0'
  if Rails.version < '5'
    module ActionController
      class TestResponse < ActionDispatch::TestResponse
        def recycle!
          # HACK: to avoid MonitorMixin double-initialize error:
          @mon_mutex_owner_object_id = nil
          @mon_mutex = nil
          initialize
        end
      end
    end
  else
    puts 'Monkeypatch for ActionController::TestResponse no longer needed'
  end
end

describe GraduateApplicationsController do
  describe 'submitting a graduate application' do
    before(:each) do
      @sample_application = {
        first_name: 'John',
        last_name: 'Doe',
        email: 'johndoe@uiowa.edu',
        phone: '14118839251',
        dob: Date.new,
        gpa_value: '3.4',
        gpa_scale: '4.0'
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
        @sample_application[:gpa_value] = 5.0
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
        post :create, graduate_application: @sample_application.except!(:gpa_scale)
        expect(flash[:notice]).to match(/Application submission failed, please retry./)
      end
    end
  end
  describe 'withdrawing an application' do
    before(:each) do
      @sample_application = {
        first_name: 'John',
        last_name: 'Doe',
        email: 'johndoe@uiowa.edu',
        phone: '14118839251',
        dob: Date.new,
        gpa_value: '3.4',
        gpa_scale: '4.0',
        status: 'submitted'
      }
      GraduateApplication.create!(@sample_application)
    end
    it 'should call the model method that does the withdrawal' do
      mock = instance_double(GraduateApplication)
      expect(GraduateApplication).to receive(:find_by).with(email: 'johndoe@uiowa.edu').and_return(mock)
      expect(mock).to receive(:withdraw)
      patch :withdraw, { application: @sample_application }
    end
    it 'should select the home page for rendering' do
      patch :withdraw, { application: @sample_application }
      expect(response).to redirect_to('/home')
    end
    it 'should flash message that application was withdrawn' do
      patch :withdraw, { application: @sample_application }
      expect(flash[:notice]).to match(/Application has been withdrawn/)
    end
  end
end
