# frozen_string_literal: true

# Migration to add column to faculties table for being approvedR
class AddApprovedColumnToFaculties < ActiveRecord::Migration
  def change
    add_column :faculties, :approved, :boolean, default: false
  end
end
