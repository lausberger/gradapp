# frozen_string_literal: true

require 'google/cloud/storage'

# Main application controller
class ApplicationController < ActionController::Base
  # rubocop:disable Lint/Void
  @student_document_bucket
  # rubocop:enable Lint/Void
  @gcloud_active = false

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_gcloud

  private

  def load_gcloud
    return if Rails.env.test? || !ENV.key?('GOOGLE_STORAGE_CREDENTIALS')

    storage = Google::Cloud::Storage.new(
      project_id: ENV['GOOGLE_STORAGE_PROJECT'],
      credentials: ENV['GOOGLE_STORAGE_CREDENTIALS']
    )
    @student_document_bucket = storage.bucket ENV['GOOGLE_STORAGE_BUCKET']
    @gcloud_active = true
  end
end
