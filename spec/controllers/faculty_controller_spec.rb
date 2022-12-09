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
  describe 'search by topic area' do
    before(:all) do
      @account = {
        email: 'joe.smith@gmail.com',
        first_name: 'Joesph',
        last_name: 'Smith',
        password: 'iloveselt23',
        password_confirmation: 'iloveselt23',
        account_type: 'faculty'
      }
      @account_creation = Account.create!(@account)
      @faculty = {
        account_id: @account_creation.id,
        topic_area: 'CSE'
      }
      @faculty_creation = Faculty.create!(@faculty)
    end
    context 'search for professors in CSE topics are' do
      it 'should select all faculties members in all topic areas' do
        get :index
        expect(response).to render_template('index')
      end
      it 'should return to index when invalid topic area searched' do
        post :search, { search_topic_area: '' }
        expect(response).to redirect_to faculties_path
        expect(flash[:warning]).to eq 'Invalid topic area specified!'
      end
      it 'should flash invalid topic area message' do
        topic_area = 'basketweaving'
        post :search, { search_topic_area: topic_area }
        expect(flash[:notice]).to eq "No faculty members with topic area matching \"#{topic_area}\" were found"
      end
      it 'should select faculties members only in CSE topic area' do
        post :search, { search_topic_area: 'CSE' }
        expect(response).to render_template('search')
      end
    end
    after(:all) do
      @faculty_creation.destroy
      @account_creation.destroy
    end
  end
end
