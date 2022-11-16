class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.integer :account_id
      t.string :topic_are

      t.timestamps null: false
    end
  end
end
