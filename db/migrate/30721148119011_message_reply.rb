# frozen_string_literal: true

# Migration for adding messages foreign key to messages table representing replies
class MessageReply < ActiveRecord::Migration
  def change
    add_reference :messages, :messages, foreign_key: true
  end
end
