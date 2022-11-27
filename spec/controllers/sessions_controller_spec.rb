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
    before(:all) do
      @account = Account.create(
        first_name: 'Guy',
        last_name: 'McDuderson',
        email: 'amanda-huginkiss@uiowa.edu',
        password: 'password',
        password_confirmation: 'password',
        type: 'Student',
        id: 69
      )
    end

    context 'with valid information' do
      before(:all) do
        @session_params = { email: @account.email, password: @account.password }
      end
      it 'should redirect back to home page' do
        allow(Account).to receive(:find_by).and_return @account
        post :create, { session: @session_params }
        expect(response).to redirect_to root_path
      end
      it 'should flash a success notice' do
        allow(Account).to receive(:find_by).and_return @account
        post :create, { session: @session_params }
        expect(flash[:notice]).to eq "Welcome, #{@account.first_name}."
      end
      it 'should be possible to view user profile' do
        # this one is :find rather than :find_by because of application#logged_in?
        allow(Account).to receive(:find).and_return @account
        post :create, { session: @session_params }
        @controller = AccountsController.new
        get :show
        expect(response).to render_template :show
        @controller = SessionsController.new
      end
      it 'should have session info' do
        allow(Account).to receive(:find_by).and_return @account
        post :create, { session: @session_params }
        expect(session[:user_id]).to eq @account.id
      end
    end

    context 'with incorrect information' do
      before(:all) do
        @session_params = { email: 'wrong-email@email.email', password: @account.password }
      end
      it 'should render the login page' do
        post :create, { session: @session_params }
        expect(response).to render_template :new
      end
      it 'should flash an alert informing the user of incorrect credentials' do
        post :create, { session: @session_params }
        expect(flash[:warning]).to eq 'Email or password is incorrect'
      end
    end

    context 'with invalid information' do
      context 'missing email' do
        before(:all) do
          @session_params = { email: '', password: @account.password }
        end
        it 'should render the login page' do
          post :create, { session: @session_params }
          expect(response).to render_template :new
        end
        it 'should inform the user of an empty email field' do
          post :create, { session: @session_params }
          expect(flash[:warning]).to eq 'Email field cannot be empty'
        end
      end

      context 'invalid email' do
        before(:all) do
          @session_params = { email: 'email lol', password: @account.password }
        end
        it 'should redirect back to login page' do
          post :create, { session: @session_params }
          expect(response).to render_template :new
        end
        it 'should inform the user of an invalid email' do
          post :create, { session: @session_params }
          expect(flash[:warning]).to eq 'Please provide a valid email address'
        end
      end

      context 'missing password' do
        before(:all) do
          @session_params = { email: @account.email, password: '' }
        end
        it 'should redirect back to login page' do
          post :create, { session: @session_params }
          expect(response).to render_template :new
        end
        it 'should inform the user of an empty password field' do
          post :create, { session: @session_params }
          expect(flash[:warning]).to eq 'Password field cannot be empty'
        end
      end
    end
  end

  describe 'logging out' do
    it 'should redirect back to the home page' do
      delete :destroy
      expect(response).to redirect_to root_path
    end
    it 'should display a notice of successful logout' do
      delete :destroy
      expect(flash[:notice]).to eq 'You have been signed out successfully.'
    end
    it 'should have null session id' do
      delete :destroy
      expect(session[:user_id]).to be nil
    end
    context 'and attempting session-specific actions' do
      it 'should not be possible to view the user profile' do
        delete :destroy
        @controller = AccountsController.new
        get :show
        expect(response).to redirect_to login_path
        @controller = SessionsController.new
      end
      it 'should display a notice regarding the login session' do
        delete :destroy
        @controller = AccountsController.new
        get :show
        expect(flash[:warning]).to eq 'You must be logged in to perform that action'
        @controller = SessionsController.new
      end
    end
  end
end
