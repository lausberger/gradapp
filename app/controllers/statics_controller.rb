# frozen_string_literal: true

# rubocop: disable Rails/ApplicationController

# Main controller for handling static page generation
class StaticsController < ApplicationController
  helper_method :current_user, :home

  def home
    if not !!current_user then
      render 'public_home'
    elsif current_user.account_type == "Student" then
      render 'student_home'
    elsif current_user.account_type == "Faculty" then
      render 'faculty_home'
    elsif current_user.account_type == "Chair" then
      render 'chair_home'
    else
      render 'public_home'
    end
  end
end

# rubocop: enable Rails/ApplicationController
