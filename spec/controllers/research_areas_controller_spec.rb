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
    context 'with valid info' do
      before(:each) do
        @research_area = {
          title: 'Networks',
          summary: 'A test networks research area',
          detailed_overview: 'This research area is made to tests faculty, and it represent a possible networks area'
        }
      end
      it 'should redirect to home page and flash a success message' do
        post :create, { research_area: @research_area }
        expect(response).to redirect_to research_areas_path
        expect(flash[:notice]).to eq 'Research area successfully added'
      end
    end
    context 'with invalid info' do
      context 'title already used' do
        before(:each) do
          @research_area = {
            title: 'Networks',
            summary: 'A test networks research area',
            detailed_overview: 'This research area is made to tests faculty, and it represent a possible networks area'
          }
          allow(ResearchArea).to receive(:find_by).and_return(@research_area)
        end
        it 'should re-render new' do
          post :create, { research_area: @research_area }
          expect(response).to render_template('new')
        end
        it 'should display error message' do
          post :create, { research_area: @research_area }
          expect(flash[:warning]).to eq 'Research area title already exists'
        end
      end
    end
  end
  describe 'viewing all research areas' do
    it 'should load the index page' do
      get :index
      expect(response).to render_template('index')
    end
  end
  describe 'viewing a specific research are' do
    before(:each) do
      research_area = {
        title: 'Test',
        summary: 'Area for testing',
        detailed_overview: 'Research Area for Testing'
      }
      ResearchArea.create! research_area
    end
    it 'should load the show page' do
      get :show, { id: ResearchArea.find_by(title: 'Test').id }
      expect(response).to render_template('show')
    end
  end
end
