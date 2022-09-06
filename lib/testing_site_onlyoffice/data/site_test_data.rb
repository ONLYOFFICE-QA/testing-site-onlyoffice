# frozen_string_literal: true

# Stores all constants that are used in specs
class SiteTestData
  DOC_FORMATS = %w[docm docxf dotm dotx epub fb2 html odt ott pdf pdfa rtf txt].freeze
  SPREADSHEET_FORMATS = %w[csv ods ots pdf pdfa xlsm xltm xltx].freeze
  PRESENTATION_FORMATS = %w[odp otp pdf pdfa potm potx pptm].freeze

  main_path = "#{Dir.home}/RubymineProjects/testing-site-onlyoffice/lib/testing_site_onlyoffice/data/"
  DOC_PATH = "#{main_path}document_upload_testing.docx".freeze
  SPREADSHEET_PATH = "#{main_path}spreadsheet_upload_testing.xlsx".freeze
  PRESENTATION_PATH = "#{main_path}presentation_upload_testing.pptx".freeze
  LOG_PATH = "#{main_path}log_upload_testing.log".freeze
end
