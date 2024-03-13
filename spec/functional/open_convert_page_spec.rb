# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Convert page' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @convert_page = site_home_page.click_pdf_reader_converter.open_convert_page
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  it 'Upload .docx file' do
    @convert_page.upload_file(TestingSiteOnlyoffice::TestData.docx_path)
    @convert_page.convert_formats_button_click
    expect(@convert_page.file_formats_list).to eq(TestingSiteOnlyoffice::ConvertPage::DOC_FORMATS)
  end

  it 'Upload .xlsx file' do
    @convert_page.upload_file(TestingSiteOnlyoffice::TestData.spreadsheet_path)
    @convert_page.convert_formats_button_click
    expect(@convert_page.file_formats_list).to eq(TestingSiteOnlyoffice::ConvertPage::SPREADSHEET_FORMATS)
  end

  it 'Upload .pptx file' do
    @convert_page.upload_file(TestingSiteOnlyoffice::TestData.presentation_path)
    @convert_page.convert_formats_button_click
    expect(@convert_page.file_formats_list).to eq(TestingSiteOnlyoffice::ConvertPage::PRESENTATION_FORMATS)
  end

  it 'Upload .pdf file' do
    @convert_page.upload_file(TestingSiteOnlyoffice::TestData.pdf_path)
    @convert_page.convert_formats_button_click
    expect(@convert_page.file_formats_list).to eq(TestingSiteOnlyoffice::ConvertPage::PDF_FORMATS)
  end

  it 'Upload incorrect file format' do
    @convert_page.upload_file(TestingSiteOnlyoffice::TestData.log_path)
    expect(@convert_page).to be_error_popup_appeared
  end

  it 'pdf format is selected for .docx file' do
    @convert_page.upload_file(TestingSiteOnlyoffice::TestData.docx_path)
    expect(@convert_page.selected_format).to eq('PDF')
  end

  it 'converted file name is the same as original file name' do
    @convert_page.upload_file(TestingSiteOnlyoffice::TestData.docx_path)
    @convert_page.bypass_captcha
    @convert_page.convert_button_click
    expect(@convert_page.converted_file_name).to eq(@convert_page.get_file_name(TestingSiteOnlyoffice::TestData.docx_path))
  end

  it 'converted file is not empty' do
    @convert_page.upload_file(TestingSiteOnlyoffice::TestData.docx_path)
    extension = @convert_page.selected_format.downcase
    @convert_page.bypass_captcha
    @convert_page.convert_button_click
    @convert_page.download_button_click
    expect(@convert_page).to be_file_downloaded(TestingSiteOnlyoffice::TestData.docx_path, extension)
  end
end
