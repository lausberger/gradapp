class CreateGraduateApplications < ActiveRecord::Migration
  def change
    create_table :graduate_applications do |t|
      # Personal Details
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.datetime :dob

      # Mailing Address
      #t.hstore :address

      # Scores
      #t.text :gpa, null: false

      # Other
      t.string :status

      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
