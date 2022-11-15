require 'spec_helper'
require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe FacultysController do
  describe 'search by topic area' do
    context 'search for professors in CSE topics are' do
      <<-DOC
      before(:all) do
        @faculty_one = {
          :email => 'jnstockley@gmail.com',
          :first_name => 'Jack',
          :last_name => 'Stockley',
          :password => 'Password1234',
          :type => 'faculty',
          :topic_area => 'Math'
        }
        @faculty_two = {
          :email => 'hans-johnson@uiowa.edu',
          :first_name => 'Hans',
          :last_name => 'Johnson',
          :password => 'S3curEpA55w0rD',
          :type => 'faculty',
          :topic_area => 'Rhetoric'
        }
        @faculty_three = {
          :email => 'joe.smith@gmail.com',
          :first_name => 'Joesph',
          :last_name => 'Smith',
          :password => 'iloveselt23',
          :type => 'faculty',
          :topic_area => 'CSE'
        }
        @faculty_four = {
          :email => 'nikki-brown@yahoo.com',
          :first_name => 'Nikki',
          :last_name => 'Brown',
          :password => 'rubyIS<3',
          :type => 'faculty',
          :topic_area => 'CSE'
        }
        Faculty.create!(@faculty_one)
        Faculty.create!(@faculty_two)
        Faculty.create!(@faculty_three)
        Faculty.create!(@faculty_four)
      end
      DOC
      it 'should select all faculty members in all topic areas' do
        post :search, {:topic_area => ''}
        expect(response).to render_template('index')
      end
      it 'should select faculty members only in CSE topic area' do
        post :search, {:topic_area => 'CSE'}
        expect(response).to render_template('show')
      end
    end
  end
end
