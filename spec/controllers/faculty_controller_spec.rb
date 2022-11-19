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

describe FacultysController do
  describe 'search by topic area' do
    context 'search for professors in CSE topics are' do
      before(:all) do
        @account_one = {
          email: 'jnstockley@gmail.com',
          first_name: 'Jack',
          last_name: 'Stockley',
          password: 'Password1234',
          account_type: 'faculty'
        }
        @account_two = {
          email: 'hans-johnson@uiowa.edu',
          first_name: 'Hans',
          last_name: 'Johnson',
          password: 'S3curEpA55w0rD',
          account_type: 'faculty'
        }
        @account_three = {
          email: 'joe.smith@gmail.com',
          first_name: 'Joesph',
          last_name: 'Smith',
          password: 'iloveselt23',
          account_type: 'faculty'
        }
        @account_four = {
          email: 'nikki-brown@yahoo.com',
          first_name: 'Nikki',
          last_name: 'Brown',
          password: 'rubyIS<3',
          account_type: 'faculty'
        }
        @account_one_creation = Account.create!(@account_one)
        @account_two_creation = Account.create!(@account_two)
        @account_three_creation = Account.create!(@account_three)
        @account_four_creation = Account.create!(@account_four)
        @faculty_one = {
          account_id: @account_one_creation.id,
          topic_area: 'Math'
        }
        @faculty_two = {
          account_id: @account_two_creation.id,
          topic_area: 'Rhetoric'
        }
        @faculty_three = {
          account_id: @account_three_creation.id,
          topic_area: 'CSE'
        }
        @faculty_four = {
          account_id: @account_four_creation.id,
          topic_area: 'CSE'
        }
        @faculty_one_creation = Faculty.create!(@faculty_one)
        @faculty_two_creation = Faculty.create!(@faculty_two)
        @faculty_three_creation = Faculty.create!(@faculty_three)
        @faculty_four_creation = Faculty.create!(@faculty_four)
      end
      it 'should select all facultys members in all topic areas' do
        get :index
        expect(response).to render_template('index')
      end
      it 'should return to index when invalid topic area searched' do
        post :search, { search_topic_area: '' }
        expect(response).to redirect_to facultys_path
      end
      it 'should flash invalid topic area message' do
        post :search, { search_topic_area: 'fdfdfds' }
        expect(response).to redirect_to facultys_path
        expect(flash[:warning]).to be_present
      end
      it 'should select facultys members only in CSE topic area' do
        post :search, { search_topic_area: 'CSE' }
        expect(response).to render_template('search')
      end
      after(:all) do
        Faculty.destroy(@faculty_one_creation.id)
        Faculty.destroy(@faculty_two_creation.id)
        Faculty.destroy(@faculty_three_creation.id)
        Faculty.destroy(@faculty_four_creation.id)

        Account.destroy(@account_one_creation.id)
        Account.destroy(@account_two_creation.id)
        Account.destroy(@account_three_creation.id)
        Account.destroy(@account_four_creation.id)
      end
    end
  end
end
