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
      post :register, { account: @account }
    end

    context 'with valid information' do
      before(:all) do
        @session_params = { email: @account.email, password: @account.password }
      end
      it 'should redirect back to home page' do
        post :login, { session: @session_params }
        expect(response).to redirect_to root_path
      end
      it 'should flash a success notice' do
        expect(flash[:notice]).to eq "Welcome, #{@account[:first_name]}."
      end
      it 'should be possible to view user profile' do
        post :profile
        expect(response).to redirect_to profile_path
      end
      it 'should have session info' do
        expect(session[:user_id]).to eq @account[:id]
      end
    end

    context 'with incorrect information' do
      before(:all) do
        @session_params = { email: 'wrong-email@email.email', password: @account.password }
      end
      it 'should redirect back to login page' do
        post :login, { session: @session_params }
        expect(response).to redirect_to login_path
      end
      it 'should flash an alert informing the user of incorrect credentials' do
        expect(flash[:alert]).to eq 'Email or password is incorrect'
      end
    end

    context 'with invalid information' do
      context 'missing email' do
        before(:all) do
          @session_params = { email: '', password: @account.password }
        end
        it 'should redirect back to login page' do
          post :login, { session: @session_params }
          expect(response).to redirect_to login_path
        end
        it 'should inform the user of an empty email field' do
          expect(flash[:warning]).to eq 'Email field cannot be empty'
        end
      end

      context 'invalid email' do
        before(:all) do
          @session_params = { email: 'email lol', password: @account.password }
        end
        it 'should redirect back to login page' do
          post :login
          expect(response).to redirect_to login_path
        end
        it 'should inform the user of an invalid email' do
          expect(flash[:warning]).to eq 'Please provide a valid email address'
        end
      end

      context 'missing password' do
        it 'should redirect back to login page' do
          post :login
          expect(response).to redirect_to login_path
        end
        it 'should inform the user of an empty password field' do
          expect(flash[:warning]).to eq 'Password field cannot be empty'
        end
      end
    end
  end

  describe 'logging out' do
    before do
      post :logout
    end
    it 'should redirect back to the home page' do
      expect(response).to redirect_to root_path
    end
    it 'should display a notice of successful logout' do
      expect(flash[:notice]).to eq "You have been signed out successfully."
    end
    it 'should have null session id' do
      expect(session[:user_id]).to be nil
    end
    context 'and attempting session-specific actions' do
      it 'should not be possible to view the user profile' do
        post :profile
        expect(response).to redirect_to login_path
      end
      it 'should display a notice regarding the login session' do
        expect(flash[:notice]).to eq "Login session not found. Please sign in."
      end
    end
  end
end