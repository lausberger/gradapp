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

describe Discussion do
  describe 'Add new discussion' do
    it 'root discussion' do
      post_title = 'Root Discussion'
      post_body = 'Root discussion body'
      discussion = Discussion.create!(title: post_title, body: post_body, account_id: 1,
                                      root_discussion_id: -1)
      expect(Discussion.root_posts).to include discussion
      expect(Discussion.root_post(discussion.id)).to eq discussion
    end
    it 'reply to discussion' do
      root_post_title = 'Root Discussion'
      root_post_body = 'Root discussion body'
      root_discussion = Discussion.create!(title: root_post_title, body: root_post_body,
                                           account_id: 1, root_discussion_id: -1)
      reply_post_title = 'Root Discussion'
      reply_post_body = 'Root discussion body'
      reply_discussion = Discussion.create!(title: reply_post_title, body: reply_post_body,
                                            account_id: 1, root_discussion_id: root_discussion.id)
      expect(Discussion.post_replies(root_discussion.id)).to include reply_discussion
    end
  end
  describe 'Edit existing discussion' do
    it 'root discussion' do
      post_title = 'Root Discussion'
      post_body = 'Root discussion body'
      discussion = Discussion.create!(title: post_title, body: post_body, account_id: 1,
                                      root_discussion_id: -1)
      expect(Discussion.root_posts).to include discussion
      expect(Discussion.root_post(discussion.id)).to eq discussion
      discussion[:title] = 'New Root Discussion'
      discussion[:body] = 'New Root Discussion Body'
      discussion[:account_id] = 1
      discussion.save
      expect(Discussion.root_post(discussion.id)).to eq discussion
    end
    it 'reply to discussion' do
      root_post_title = 'Root Discussion'
      root_post_body = 'Root discussion body'
      root_discussion = Discussion.create!(title: root_post_title, body: root_post_body,
                                           account_id: 1, root_discussion_id: 0)
      reply_post_title = 'Root Discussion'
      reply_post_body = 'Root discussion body'
      reply_discussion = Discussion.create!(title: reply_post_title, body: reply_post_body,
                                            account_id: 1, root_discussion_id: root_discussion.id)
      expect(Discussion.post_replies(root_discussion.id)).to include reply_discussion
      reply_discussion[:body] = 'New Root Discussion body'
      reply_discussion[:account_id] = 1
      reply_discussion.save
      expect(Discussion.post_replies(root_discussion.id)).to include reply_discussion
    end
  end
  describe 'delete discussion' do
    it 'root discussion' do
      post_title = 'Root Discussion'
      post_body = 'Root discussion body'
      discussion = Discussion.create!(title: post_title, body: post_body, account_id: 1,
                                      root_discussion_id: -1)
      expect(Discussion.root_posts).to include discussion
      discussion.destroy
      expect(Discussion.root_posts).not_to include discussion
    end
    it 'reply to discussion' do
      root_post_title = 'Root Discussion'
      root_post_body = 'Root discussion body'
      root_discussion = Discussion.create!(title: root_post_title, body: root_post_body,
                                           account_id: 1, root_discussion_id: -1)
      reply_post_title = 'Root Discussion'
      reply_post_body = 'Root discussion body'
      reply_discussion = Discussion.create!(title: reply_post_title, body: reply_post_body,
                                            account_id: 1, root_discussion_id: root_discussion.id)
      expect(Discussion.post_replies(root_discussion.id)).to include reply_discussion
      reply_discussion.destroy
      expect(Discussion.post_replies(root_discussion.id)).not_to include reply_discussion
      expect(Discussion.root_posts).to include root_discussion
    end
  end
end
