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
  before(:each) do
    @account = {
      email: 'jnstockley2@gmail.com',
      first_name: 'Jack',
      last_name: 'Stockley',
      password: 'Password1234',
      password_confirmation: 'Password1234',
      account_type: 'faculty'
    }
    @account_creation = Account.create!(@account)
    @research_area = {
      title: 'Networks Three',
      summary: 'A test networks research area',
      detailed_overview: 'This research area is made to tests faculty, and it represent a possible networks area'
    }
    @research_area_creation = ResearchArea.create! @research_area
    @faculty = {
      account_id: @account_creation.id,
      research_area_id: @research_area_creation.id
    }
  end
  describe 'topic area validation' do
    it 'should pass on valid faculty account' do
      @faculty[:research_area_id] = @research_area_creation.id
      expect(Faculty.new(@faculty).valid?).to eq true
    end
  end
  describe 'adding faculty account' do
    context 'Faculty' do
      it 'should appear with the research area id' do
        faculty_creation = Faculty.create!(@faculty)
        expect(Faculty.where(research_area_id: faculty_creation[:research_area_id])).to exist
        faculty_creation.destroy
      end
    end
    after(:each) do
      @account_creation.destroy
      @research_area_creation.destroy
    end
  end
end
