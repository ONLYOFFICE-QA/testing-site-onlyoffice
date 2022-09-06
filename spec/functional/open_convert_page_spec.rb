# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

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

  it 'Upload .docx file' do
    @convert_page.upload_file(SiteTestData::DOC_PATH)
    @convert_page.convert_formats_button_click
    expect(@convert_page.file_formats_list).to eq(SiteTestData::DOC_FORMATS)
  end

  it 'Upload .xlsx file' do
    @convert_page.upload_file(SiteTestData::SPREADSHEET_PATH)
    @convert_page.convert_formats_button_click
    expect(@convert_page.file_formats_list).to eq(SiteTestData::SPREADSHEET_FORMATS)
  end

  it 'Upload .pptx file' do
    @convert_page.upload_file(SiteTestData::PRESENTATION_PATH)
    @convert_page.convert_formats_button_click
    expect(@convert_page.file_formats_list).to eq(SiteTestData::PRESENTATION_FORMATS)
  end

  it 'Upload incorrect file format' do
    @convert_page.upload_file(SiteTestData::LOG_PATH)
    expect(@convert_page).to be_error_popup_appeared
  end
end
