# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
main_path = "#{Dir.home}/RubymineProjects/testing-site-onlyoffice/lib/testing_site_onlyoffice/data/"
doc_file_path = "#{main_path}document_upload_testing.docx"
spreadsheet_file_path = "#{main_path}testing_upload_spreadsheet.xls"
presentation_file_path = "#{main_path}testing_upload_presentation.pptx"
log_file_path = "#{main_path}testing_upload_log.log"

describe 'Convert page' do
  before do
    @site_main_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @convert_page = @site_main_page.open_convert_page
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  it 'Open convert page' do
    expect(@convert_page).to be_file_input_present
  end

  it 'Upload .doc file' do
    @convert_page.upload_file(doc_file_path)
  end
end
