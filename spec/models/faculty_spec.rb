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

describe Faculty do
  describe 'topic area validation' do
    before(:each) do
      @faculty_account = {
        :first_name => 'Jack',
        :last_name => 'Stockley',
        :email => 'jnstockley@uiowa.edu',
        :password_digest => 'password123',
        :type => 'Faculty',
        :topic_area => 'CSE'
      }
    end
    it 'should fail on nil topic_area' do
      @faculty_account[:topic_area] = nil
      expect(Faculty.new(@faculty_account).valid?).to eq false
    end
    it 'should pass on valid faculty account' do
      @faculty_account[:topic_area] = 'CSE'
      expect(Faculty.new(@faculty_account).valid?).to eq true
    end
  end
  describe 'adding faculty account' do
    context 'Faculty' do
      before(:all) do
        @faculty_account = {
          :first_name => 'Jack',
          :last_name => 'Stockley',
          :email => 'jnstockley@uiowa.edu',
          :password_digest => 'password123',
          :type => 'Faculty',
          :topic_area => 'CSE'
        }
      end
      it 'should appear in CSE topic area' do
        expect(Faculty.where(topic_are: @faculty_account[:topic_are])).to exist
      end
    end
  end
end
