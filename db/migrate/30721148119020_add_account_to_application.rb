# frozen_string_literal: true

# Adds account reference to graduate applications
class AddAccountToApplication < ActiveRecord::Migration
  def change
    add_reference :graduate_applications, :account, index: true
  end
end
