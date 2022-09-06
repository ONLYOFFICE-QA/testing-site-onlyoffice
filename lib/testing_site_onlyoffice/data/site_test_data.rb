# frozen_string_literal: true

# Stores all constants that are used in specs
class SiteTestData
  DOC_FORMATS = %w[docm docxf dotm dotx epub fb2 html odt ott pdf pdfa rtf txt].freeze
  SPREADSHEET_FORMATS = %w[csv ods ots pdf pdfa xlsm xltm xltx].freeze
  PRESENTATION_FORMATS = %w[odp otp pdf pdfa potm potx pptm].freeze

  @main_path = "#{Dir.home}/RubymineProjects/testing-site-onlyoffice/lib/testing_site_onlyoffice/data/"

  # Gets the path of the sample .docx file
  # @return [String] the path to the .docx file
  def self.docx_path
    "#{@main_path}document_upload_testing.docx"
  end

  # Gets the path of the sample .xlsx file
  # @return [String] the path to the .xlsx file
  def self.spreadsheet_path
    "#{@main_path}spreadsheet_upload_testing.xlsx"
  end

  # Gets the path of the sample .pptx file
  # @return [String] the path to the .pptx file
  def self.presentation_path
    "#{@main_path}presentation_upload_testing.pptx"
  end

  # Gets the path of the sample .log file
  # @return [String] the path to the .log file
  def self.log_path
    "#{@main_path}log_upload_testing.log"
  end
end
