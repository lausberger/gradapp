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

describe ApproveFacultiesController do
  describe 'view faculty accounts needing approval' do
    before(:each) do
      @student_account = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        password: 'password',
        password_confirmation: 'password',
        account_type: 'Student'
      }
      @faculty_account = {
        first_name: 'John',
        last_name: 'Smith',
        email: 'john-smith@uiowa.edu',
        password: 'password123',
        password_confirmation: 'password123',
        account_type: 'Faculty'
      }
      @student_account_creation = Account.create! @student_account
      @faculty_account_creation = Account.create! @faculty_account

      @faculty_account_two = {
        account_id: @faculty_account_creation.id,
        topic_area: 'Networks',
        approved: false
      }
      @faculty_account_two_creation = Faculty.create! @faculty_account_two
    end
    it 'should render the show template' do
      get :show
      expect(response).to render_template('show')
    end
  end
  describe 'approve faculty account' do
    it 'should render the show template' do
      put :update, { id: @faculty_account_creation.id }
      expect(response).to render_template('show')
    end
  end
end
