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
describe StudentChecklist do
  describe 'check default values' do
    before(:each) do
      account = {
        first_name: 'Caleb',
        last_name: 'Marx',
        email: 'caleb-marx@uiowa.edu',
        password: 'pA55W0rd!',
        password_confirmation: 'pA55W0rd!',
        account_type: 'Student'
      }
      Account.create account
      StudentChecklist.delete_all
      @student_checklist = {
        account_id: Account.find_by(first_name: 'Caleb').id
      }
      @student = StudentChecklist.create @student_checklist
    end
    it 'check citizenship value' do
      expect(@student[:citizenship]).to be false
    end
    it 'check research_area value' do
      expect(@student[:citizenship]).to be false
    end
    it 'check degree_objective value' do
      expect(@student[:research_area]).to be false
    end
    it 'check ug_inst value' do
      expect(@student[:ug_inst]).to be false
    end
    it 'check ug_gpa value' do
      expect(@student[:ug_gpa]).to be false
    end
    it 'check ug_degree value' do
      expect(@student[:ug_degree]).to be false
    end
    it 'check ug_major value' do
      expect(@student[:ug_major]).to be false
    end
    it 'check ug_transcript value' do
      expect(@student[:ug_transcript]).to be false
    end
    it 'check grad_inst value' do
      expect(@student[:grad_inst]).to be false
    end
    it 'check grad_gpa value' do
      expect(@student[:grad_gpa]).to be false
    end
    it 'check grad_degree value' do
      expect(@student[:grad_degree]).to be false
    end
    it 'check grad_major value' do
      expect(@student[:grad_major]).to be false
    end
    it 'check grad_transcript value' do
      expect(@student[:grad_transcript]).to be false
    end
    it 'check letter_recommendations value' do
      expect(@student[:letter_recommendations]).to be false
    end
    it 'check gre_scores value' do
      expect(@student[:gre_scores]).to be false
    end
    it 'check language_scores value' do
      expect(@student[:language_scores]).to be false
    end
    it 'check resume value' do
      expect(@student[:resume]).to be false
    end
    it 'check sop value' do
      expect(@student[:sop]).to be false
    end
  end
end
