class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :to, null: false
      t.references :from, null: false
      t.string :to_name, null: false
      t.string :from_name, null: false
      t.string :subject
      t.string :body
    end
    add_foreign_key :messages, :accounts, column: :to
    add_foreign_key :messages, :accounts, column: :from
  end
  def down
    drop_table :messages
  end
end
