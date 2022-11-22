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

describe SessionsController do
  describe 'logging in' do
    before do
      @account = {
        first_name: 'Lucas',
        last_name: 'Ausberger',
        email: 'lausberger@uiowa.edu',
        password: 'password',
        password_confirm: 'password',
        type: 'Student'
      }
      post '/register', { account: @account }
    end

    context 'with correct information' do
      it 'should redirect back to home page' do
        post :login
        expect(response).to redirect_to root_path
      end
      it 'should flash a success notice' do
        pending
        expect(flash[:notice]).to eq "Welcome, #{@account[:first_name]}."
      end
    end

    context 'with incorrect information' do
      it 'should redirect back to login page' do
        post :login
        expect(response).to redirect_to login_path
      end
      it 'should flash an alert informing the user of incorrect credentials' do
        expect(flash[:alert]).to eq 'Incorrect email or password'
      end
    end

    context 'with invalid information' do
      context 'missing email' do
        it 'should redirect back to login page' do
          post :login
          expect(response).to redirect_to login_path
        end
        it 'should inform the user of an empty email field' do
          expect(flash[:notice]).to eq 'Email field cannot be empty'
        end
      end

      context 'invalid email' do
        it 'should redirect back to login page' do
          post :login
          expect(response).to redirect_to login_path
        end
        it 'should inform the user of an invalid email' do
          expect(flash[:notice]).to eq 'Please provide a valid email address'
        end
      end

      context 'missing password' do
        it 'should redirect back to login page' do
          post :login
          expect(response).to redirect_to login_path
        end
        it 'should inform the user of an empty password field' do
          expect(flash[:notice]).to eq 'Password field cannot be empty'
        end
      end
    end
  end
end