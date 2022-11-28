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
  before(:each) do
    @student_checklist = {
      student_id: 1
    }
    @student = StudentChecklist.create! @student_checklist
  end
  describe 'completing new checklist item' do
    it 'should redirect to checklist page' do
      put :update, { citizenship: 1, id: @student.id }
      expect(response).to redirect_to student_checklist_path
    end
  end
end
