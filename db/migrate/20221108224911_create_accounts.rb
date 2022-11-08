class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :first, null: false
      t.string :last, null: false
      t.string :email, null: false
      t.string :password_digest, null:false
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
