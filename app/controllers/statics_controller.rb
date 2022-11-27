# frozen_string_literal: true

# rubocop: disable Rails/ApplicationController

# Main controller for handling static page generation
class StaticsController < ActionController::Base
  def home
    # default: render 'home' template
  end
end

# rubocop: enable Rails/ApplicationController
