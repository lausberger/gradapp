# frozen_string_literal: true

# Controller class for documents
class DocumentsController < ApplicationController
  def download
    document = Document.find_by(id: params[:id])
    redirect_to google_download_path(document.file_ref)
  end

  private

  def google_download_path(path)
    google_file = @student_document_bucket.file path
    google_file.signed_url
  end
end
