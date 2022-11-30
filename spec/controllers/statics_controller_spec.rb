# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe StaticsController do
  describe 'When accessing the home page' do
    context 'while not logged in ' do
      before(:all) do
        delete :destroy
      end
      it 'should render the public home page' do
        get 'home'
        expect(response).to render_template('public_home')
      end
    end
    context 'while logged in as a student' do
      before(:all) do
        @account = Account.create(
          first_name: 'Test',
          last_name: 'Student',
          email: 'test-student@uiowa.edu',
          password: 'password',
          password_confirmation: 'password',
          account_type: 'Student',
          id: 1
        )
        @session_params = { email: @account.email, password: @account.password }
        allow(Account).to receive(:find_by).and_return @account
        post :create, { session: @session_params }
      end
      it 'should render the student home page' do
        get 'home'
        expect(response).to render_template('student_home')
      end
    end
    context 'while logged in as a faculty' do
      before(:all) do
        @account = Account.create(
          first_name: 'Test',
          last_name: 'Faculty',
          email: 'test-faculty@uiowa.edu',
          password: 'password',
          password_confirmation: 'password',
          account_type: 'Faculty',
          id: 2
        )
        @session_params = { email: @account.email, password: @account.password }
        allow(Account).to receive(:find_by).and_return @account
        post :create, { session: @session_params }
      end
      it 'should render the faculty home page' do
        get 'home'
        expect(response).to render_template('faculty_home')
      end
    end
  end
  describe 'FAQ Page' do
    it 'should render the statics template for faq page' do
      get 'faq'
      expect(response).to render_template('faq')
    end
  end
  if RUBY_VERSION >= '2.6.0'
    if Rails.version < '5'
      module ActionController
        class TestResponse < ActionDispatch::TestResponse
          def recycle!
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
end
