# frozen_string_literal: true

class Faculty < ActiveRecord::Base
  belongs_to :account
  belongs_to :research_area
end
