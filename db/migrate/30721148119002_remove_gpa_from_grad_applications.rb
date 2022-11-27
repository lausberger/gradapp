# frozen_string_literal: true

# GPA has been moved over to the new education model and no longer should be included
# in the graduate application table.
class RemoveGpaFromGradApplications < ActiveRecord::Migration
  def change
    remove_column :graduate_applications, :gpa_value
    remove_column :graduate_applications, :gpa_scale
  end
end
