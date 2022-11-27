# frozen_string_literal: true

# Model class for documents - files which can be attached to applications
class Document < ActiveRecord::Base
  belongs_to :graduate_application

  validates :name, presence: true, format: { with: /\A.{1,50}\z/, message: 'name must be between 1-50 characters long' }
  validates :description, format: { with: /\A.*\z/, message: 'must be a valid string' }
  validates :file_ref, presence: true, format: { with: /\A.+\z/, message: 'file reference must be a string' }
end
