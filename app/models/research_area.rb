# frozen_string_literal: true

class ResearchArea < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
