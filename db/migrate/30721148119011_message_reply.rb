class MessageReply < ActiveRecord::Migration
  def change
    add_reference :messages, :messages, foreign_key: true
  end
end
