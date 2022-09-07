# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Stores all constants that are used in specs
  class TestData
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
end
