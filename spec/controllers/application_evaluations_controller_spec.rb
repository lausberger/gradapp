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
      @dummy_app = instance_double(GraduateApplication)
      allow(@dummy_app).to receive(:valid?).and_return(true)

      allow(GraduateApplication).to receive(:find).and_return(@dummy_app)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(true)
      @sample_evaluation = {
        score: 5,
        comment: 'This is a comment',
        graduate_application_id: 1
      }

      @account = {
        first_name: 'Not Lucas',
        last_name: 'Not Ausberger',
        email: 'exampleemail@uiowa.edu',
        password: 'password',
        password_confirmation: 'password',
        account_type: 'Faculty'
      }
      @test_account = Account.create!(@account)
      controller.instance_variable_set(:@current_user, @test_account)
    end
    describe 'creating a valid application evaluation' do
      it 'should flash a success message' do
        params = {
          'comment' => @sample_evaluation[:comment],
          'account_id' => @test_account.id,
          'score' => @sample_evaluation[:score]
        }
        test = class_double(ApplicationEvaluation)
        expect(test).to receive(:create).with(params)
        expect(@dummy_app).to receive(:application_evaluations).and_return(test)

        post :create, { application_evaluation: @sample_evaluation }
      end
    end
    describe "creating an evaluation for an application that doesn't exist" do
      it 'should fail' do
      end
    end
    describe 'updating an evaluation' do
    end
  end
end
