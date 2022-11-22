class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :to, null: false, foreign_key: {to_table: :account}
      t.references :from, null: false, foreign_key: {to_table: :account}
      t.string :to_name, null: false
      t.string :from_name, null: false
      t.string :subject
      t.string :body
    end
  end
end
