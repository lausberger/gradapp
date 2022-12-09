# frozen_string_literal: true

class ResearchArea < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :summary, presence: true
  validates :detailed_overview, presence: true
end
