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

describe StudentChecklistsController do
  describe 'viewing student checklist' do
    it 'should redirect to login page' do
      get :index
      expect(response).to redirect_to login_path
    end
    it 'should redirect to home page' do
      acc = create(:account, :faculty)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      get :index
      expect(response).to redirect_to home_path
    end
    it 'should render index template' do
      acc = create(:account)
      checklist = {
        account_id: acc.id
      }
      @student_checklist = StudentChecklist.create checklist
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      get :index
      expect(response).to render_template('index')
    end
  end
  describe 'updating student checklist' do
    it 'should render index template' do
      acc = create(:account)
      checklist = {
        account_id: acc.id
      }
      @student_checklist = StudentChecklist.create checklist
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      put :update, {id: acc.id, citizenship_checkbox: true }
      expect(response).to redirect_to student_checklists_path
    end
  end
end
