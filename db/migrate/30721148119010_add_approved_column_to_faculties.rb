class AddApprovedColumnToFaculties < ActiveRecord::Migration
  def change
    add_column :faculties, :approved, :boolean, default: false
  end
end
