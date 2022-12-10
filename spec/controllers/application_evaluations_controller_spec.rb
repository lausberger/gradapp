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

describe ApplicationEvaluationsController do
  describe 'creating an application evaluation' do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(true)
      @sample_evaluation = {
        score: 5,
        comment: 'This is a comment'
      }

      @sample_request = {
        graduate_application: {
          id: 1
        },
        application_evaluation: @sample_evaluation
      }
    end
    describe 'creating a valid application evaluation' do
    end
    describe "creating an evaluation for an application that doesn't exist" do
      it 'should fail' do
      end
    end
    describe 'updating an evaluation' do
    end
  end
end
