# frozen_string_literal: true

# Graduate Application faculty evaluation model
class ApplicationEvaluation < ActiveRecord::Base
  def self.score_scale
    [1, 2, 3, 4, 5]
  end

  belongs_to :graduate_application
  belongs_to :account

  validates :score, presence: true, numericality: true, inclusion: { in: score_scale }
  validates :comment, format: { with: /\A.*\z/, message: 'must be a valid string' }
end
