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

describe ApproveApplicationsController do
  describe 'view application approval page' do
    before(:each) do
      application = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        phone: '8722214561',
        dob: Date.new,
        status: 'submitted'
      }
      @grad_application = GraduateApplication.create!(application)
    end
    it 'should redirect to login page' do
      get :index
      expect(response).to redirect_to login_path
    end
    it 'should flash message saying you aren\'t signed in as dept. chair' do
      acc = create(:account, :faculty)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      get :index
      expect(response).to render_template('index')
      expect(flash[:alert]).to be_present
    end
    it 'should show applications needing approval' do
      acc = create(:account, :department_chair)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      get :index
      expect(response).to render_template('index')
      expect(flash[:alert]).to_not be_present
    end
    describe 'make decision on application' do
      it 'should approve grad application and render show template' do
        acc = create(:account, :department_chair)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return acc
        put :update, { id: @grad_application.id, commit: 'approve' }
        expect(response).to redirect_to approve_applications_path
      end
      it 'should deny grad application and render show template' do
        acc = create(:account, :department_chair)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return acc
        put :update, { id: @grad_application.id, commit: 'deny' }
        expect(response).to redirect_to approve_applications_path
      end
    end
  end
end
