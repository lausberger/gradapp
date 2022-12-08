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

describe ResearchAreasController do
  describe 'accessing the form to create a new program' do
    context 'while not logged in ' do
      it 'should render the login page with flash warning' do
        get 'new'
        expect(response).to redirect_to login_path
        expect(flash[:warning]).to eq 'You must be logged in to perform that action'
      end
    end
    context 'while logged in without permission' do
      before(:each) do
        @account = Account.create(
          first_name: 'Test',
          last_name: 'Student',
          email: 'test-student@uiowa.edu',
          password: 'password',
          password_confirmation: 'password',
          account_type: 'Student',
          id: 1
        )
        ResearchAreasController.any_instance.stub(:current_user).and_return(@account)
      end
      it 'should render the home page with flash warning' do
        get 'new'
        expect(response).to redirect_to home_path
        expect(flash[:warning]).to eq 'You do not have permission to perform this action'
      end
    end
    context 'while logged in with permission' do
      before(:each) do
        @account = Account.create(
          first_name: 'Test',
          last_name: 'Faculty',
          email: 'test-faculty@uiowa.edu',
          password: 'password',
          password_confirmation: 'password',
          account_type: 'Faculty',
          id: 2
        )
        ResearchAreasController.any_instance.stub(:current_user).and_return(@account)
      end
      it 'should render corresponding page' do
        get 'new'
        expect(response).to render_template('new')
      end
    end
  end
  describe 'creating a new program' do
  end
end
