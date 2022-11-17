class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.references :account, index: true, foreign_key: true
      t.string :topic_area

      t.timestamps null: false
    end
  end
end
