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
      @faculty_account = {
        first_name: 'John',
        last_name: 'Smith',
        email: 'john-smith@uiowa.edu',
        password: 'password123',
        password_confirmation: 'password123',
        account_type: 'Faculty'
      }
      @research_area = {
        title: 'Networks Four',
        summary: 'A test networks research area',
        detailed_overview: 'This research area is made to tests faculty, and it represent a possible networks area'
      }
      @research_area_creation = ResearchArea.create! @research_area
      @faculty_account_creation = Account.create! @faculty_account
      @faculty_account_two = {
        account_id: @faculty_account_creation.id,
        research_area_id: @research_area_creation.id,
        approved: false
      }
      @faculty_account_two_creation = Faculty.create! @faculty_account_two
    end
    it 'should redirect home with a flash if user isn\'t dept chair' do
      acc = create(:account, :faculty)
      ApplicationController.any_instance.stub(:current_user).and_return acc
      get :index
      expect(response).to redirect_to home_path
      expect(flash[:alert]).to eq 'You do not have permission to perform that action'
    end
    describe 'approve faculty account as dept chair' do
      it 'should render the show template' do
        acc = create(:account, :department_chair)
        ApplicationController.any_instance.stub(:current_user).and_return acc
        put :update, { id: @faculty_account_two_creation.id }
        expect(response).to redirect_to approve_faculties_path
      end
    end
    describe 'try to approve faculty account as non-dept chair account' do
      it 'should redirect to home page with an alert' do
        acc = create(:account, :faculty)
        ApplicationController.any_instance.stub(:current_user).and_return acc
        put :update, { id: @faculty_account_two_creation.id }
        expect(response).to redirect_to home_path
        expect(flash[:alert]).to eq 'You do not have permission to perform that action'
      end
    end
    after(:each) do
      @faculty_account_creation.destroy
      @research_area_creation.destroy
    end
  end
end
