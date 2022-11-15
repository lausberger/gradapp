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

describe DiscussionsController do
  describe 'adding discussion post' do
    context 'create discussion' do
      before(:all) do
        @root_discussion = {
          :title => 'dsf',
          :body => 'fdfdfd',
          :author => 'fdfdfd',
          :root_discussion_id => -1
        }
        @reply_discussion = {
          :title => '',
          :body => 'dsdfs',
          :author => 'fdfd',
          :root_discussion_id => 1
        }
      end
      it 'should add selected root discussion to db and load index template' do
        post :create, {:discussion => @root_discussion}
        expect(response).to redirect_to(discussions_path)
      end
      it 'should add reply to selected discussion to db and load show template for root discussion' do
        post :create_reply, {:root_discussion_id => @reply_discussion[:root_discussion_id], :body => @reply_discussion[:body], :author => @reply_discussion[:author]}
        expect(response).to redirect_to(discussion_path(@reply_discussion[:root_discussion_id]))
      end
    end

    describe 'delete discussion post' do
      context 'find posts' do
        before(:all) do
          @root_discussion = {
            :title => 'dsf',
            :body => 'fdfdfd',
            :author => 'fdfdfd',
            :root_discussion_id => -1
          }
          @reply_discussion = {
            :title => '',
            :body => 'dsdfs',
            :author => 'fdfd',
            :root_discussion_id => 1
          }
          end
        it 'should delete reply discussion from db and load show template' do
          post :create_reply, {:root_discussion_id => @reply_discussion[:root_discussion_id], :body => @reply_discussion[:body], :author => @reply_discussion[:author]}
          expect(response).to redirect_to(discussion_path(@reply_discussion[:root_discussion_id]))
          @id = Discussion.find_by_body(@reply_discussion[:body]).id
          delete :destroy, {:id => @id}
          expect(response).to redirect_to(discussion_path(@reply_discussion[:root_discussion_id]))
        end
        it 'should delete root discussion from db and load show template for root discussion' do
          post :create, {:discussion => @root_discussion}
          expect(response).to redirect_to(discussions_path)
          @id = Discussion.find_by_body(@root_discussion[:body]).id
          delete :destroy, {:id => @id}
          expect(response).to redirect_to(discussions_path)
        end
      end
      end
  end
end
