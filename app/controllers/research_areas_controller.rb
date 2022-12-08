# frozen_string_literal: true

# Controller for research areas
class ResearchAreasController < ApplicationController
  before_action :require_login_as_faculty_or_staff, only: [:new]
  def new; end
  def create; end

end
