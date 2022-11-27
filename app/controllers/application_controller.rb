# frozen_string_literal: true
require "google/cloud/storage"

class ApplicationController < ActionController::Base
  @@student_document_bucket

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_gcloud

  private

  def load_gcloud
    if !defined?(@@student_document_bucket)
      storage = Google::Cloud::Storage.new(
        project_id: "selt-grad-app",
        credentials: "selt-grad-app-287ce054d81a.json"
      )
      @@student_document_bucket = storage.bucket 'selt-grad-app-student-documents'
    end
  end

end
