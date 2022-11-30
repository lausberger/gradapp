# frozen_string_literal: true

# Main controller for handling static page generation
class StaticsController < ApplicationController
  helper_method :current_user, :home

  def home
    if !!!current_user
      render 'public_home'
    elsif current_user.account_type == 'Student'
      render 'student_home'
    elsif current_user.account_type == 'Faculty'
      render 'faculty_home'
    elsif current_user.account_type == 'Chair'
      render 'chair_home'
    else
      render 'public_home'
    end
  end
end
