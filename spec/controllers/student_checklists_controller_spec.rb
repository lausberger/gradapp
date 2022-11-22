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

describe StudentChecklistsController do
  describe 'completing new checklist item' do
    before(:all) do
      @student_checklist = {
        :student_id => 1
      }
      @student = StudentChecklist.create! @student_checklist
    end
    it 'should redirect to checklist page' do
      put :update, {:citizenship => 1, :id => @student.id}
      expect(response).to redirect_to student_checklist_path
    end
    after(:all) do
      StudentChecklist.find_by(:student_id => 1).destroy
    end
  end
end
