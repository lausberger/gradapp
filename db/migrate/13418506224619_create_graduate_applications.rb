class CreateGraduateApplications < ActiveRecord::Migration
  def change
    create_table :graduate_applications do |t|
      # Personal Details
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.date :dob, null: false

      # Mailing Address
      #t.hstore :address

      # Scores
      #t.text :gpa, null: false

      # Other
      t.string :status, null: false

      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
