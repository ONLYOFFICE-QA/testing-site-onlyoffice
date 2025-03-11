# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Developers - Document Builder' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @document_builder = site_home_page.click_link_on_toolbar(:for_developers_document_builder)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Developers] [Document Builder] "Download now" button at top block works' do
    expected_title = 'ONLYOFFICE'
    @document_builder.click_get_started_top
    expect(@document_builder.check_opened_page_title).to eq(expected_title)
  end

  it '[Developers] [Document Builder] Live demo for Document works' do
    @document_builder.click_document_processing_and_download_file
    expect(@document_builder).to be_file_downloaded('sampletext.docx')
  end

  it '[Developers] [Document Builder] Live demo for Spreadsheet works' do
    @document_builder.click_spreadsheet_creation_and_download_file
    expect(@document_builder).to be_file_downloaded('samplespreadsheet.xlsx')
  end

  it '[Developers] [Document Builder] Live demo for Presentation works' do
    @document_builder.click_presentation_creation_and_download_file
    expect(@document_builder).to be_file_downloaded('samplepresentation.pptx')
  end

  it '[Developers] [Document Builder] Live demo for Form works' do
    @document_builder.click_form_building_and_download_file
    expected_form_title = 'sampleform.pdf'
    expect(@document_builder.opened_file_url).to include(expected_form_title)
  end

  it '[Developers] [Document Builder] Live demo for PDF works' do
    @document_builder.click_pdf_generating_and_download_file
    expected_pdf_title = 'sampleformats.pdf'
    expect(@document_builder.opened_file_url).to include(expected_pdf_title)
  end

  it '[Developers] [Document Builder] "Read documentaion" link at top block works' do
    expected_title = 'Overview'
    @document_builder.read_documentaion_top
    expect(@document_builder.check_opened_page_title).to eq(expected_title)
  end

  it '[Developers] [Document Builder] "Read documentaion" link at bottom block works' do
    expected_title = 'Overview'
    @document_builder.read_documentaion_bottom
    expect(@document_builder.check_opened_page_title).to eq(expected_title)
  end

  it '[Developers] [Document Builder] "Download now" button at bottom block works' do
    result_page = @document_builder.click_download_now_bottom
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDownloadDocBuilder
  end

  it '[Developers] [Document Builder] "Docs developer" link works' do
    result_page = @document_builder.click_docs_developer
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteForDevelopersDocDevEdition
  end
end
