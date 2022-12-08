# frozen_string_literal: true

# Controller for research areas
class ResearchAreasController < ApplicationController
  before_action :validate_research_area_params, only: [:create]
  before_action :require_login_as_faculty_or_staff, only: [:new]

  def index
    @research_areas = ResearchArea.all
  end
  def new; end

  def show
    research_area_id = params[:id]
    @research_area = ResearchArea.find_by(research_area_id)
    @faculty_in_research_area = Faculty.where(research_area_id: research_area_id)
  end

  def create
    @research_area = ResearchArea.new(creation_params)
    if ResearchArea.find_by(title: @research_area.title)
      flash[:warning] = 'Research area title already exists'
    elsif @research_area.save
      flash[:notice] = 'Research area successfully added'
      redirect_to home_path and return
    else
      flash[:alert] = 'Research area creation failed, please try again'
    end
    render :new
  end

  private

  def creation_params
    params.require(:research_area).permit(:title, :summary, :detailed_overview)
  end

  def validate_research_area_params
    valid = true
    research_area_params = creation_params
    (flash[:warning] = 'Fields cannot be empty') and (valid = false) if research_area_params.any? { |_k, v| v.blank? }
    render :new unless valid
  end
end
