# frozen_string_literal: true

# Discussion model class
class Discussion < ActiveRecord::Base
  def self.root_posts
    Discussion.where(root_discussion_id: -1)
  end

  def self.root_post(root_discussion_id)
    Discussion.find_by(id: root_discussion_id)
  end

  def self.post_replies(post_discussion_id)
    Discussion.where(root_discussion_id: post_discussion_id)
  end
end
