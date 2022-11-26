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

describe Faculty do
  before(:all) do
    account = {
      email: 'jnstockley@gmail.com',
      first_name: 'Jack',
      last_name: 'Stockley',
      password: 'Password1234',
      account_type: 'faculty'
    }
    @account_creation = Account.create!(account)
    @faculty = {
      account_id: @account_creation.id,
      topic_area: 'CSE'
    }
  end
  describe 'topic area validation' do
    it 'should fail on nil topic_area' do
      @faculty[:topic_area] = nil
      expect(Faculty.new(@faculty).valid?).to eq false
    end
    it 'should pass on valid faculty account' do
      @faculty[:topic_area] = 'CSE'
      expect(Faculty.new(@faculty).valid?).to eq true
    end
  end
  describe 'adding faculty account' do
    context 'Faculty' do
      it 'should appear in CSE topic area' do
        @faculty[:topic_area] = 'CSE'
        faculty_creation = Faculty.create!(@faculty)
        expect(Faculty.where(topic_area: faculty_creation[:topic_area])).to exist
      end
    end
    after(:all) do
      Account.destroy(@account_creation.id)
    end
  end
end
