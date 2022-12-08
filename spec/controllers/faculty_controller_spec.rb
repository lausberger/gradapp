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

describe FacultiesController do
  describe 'search by research area' do
    before(:all) do
      @account = {
        email: 'joe.smith2@gmail.com',
        first_name: 'Joesph',
        last_name: 'Smith',
        password: 'iloveselt23',
        password_confirmation: 'iloveselt23',
        account_type: 'faculty'
      }
      @account_creation = Account.create!(@account)
      @research_area = {
        title: 'Networks',
        summary: 'A test networks research area',
        detailed_overview: 'This research area is made to tests faculty, and it represent a possible networks area'
      }
      @research_area_creation = ResearchArea.create! @research_area
      @faculty = {
        account_id: @account_creation.id,
        research_area_id: @research_area_creation.id
      }
      @faculty_creation = Faculty.create!(@faculty)
    end
    context 'search for professors in research area' do
      it 'should select all faculties members in all research areas' do
        get :index
        expect(response).to render_template('index')
      end
      it 'should return to index and flash invalid research area when invalid research area searched' do
        post :search, { search_research_area: '' }
        expect(response).to redirect_to faculties_path
        expect(flash[:warning]).to eq 'Invalid research area specified!'
      end
      it 'should flash invalid topic area message' do
        post :search, { search_research_area: 'fdfdfds' }
        expect(response).to redirect_to faculties_path
        expect(flash[:message]).to eq 'No faculty found for given research area'
      end
      it 'should select faculties members only in CSE topic area' do
        post :search, { search_research_area: 'Networks' }
        expect(response).to render_template('search')
      end
    end
    after(:all) do
      @faculty_creation.destroy
      @account_creation.destroy
    end
  end
end
