# frozen_string_literal: true

require 'spec_helper'

CONVERSION_API_TITLE = 'Online Spreadsheet Converter | ONLYOFFICE'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'text files conversion' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  describe 'text files conversion' do
    before do
      @text_convert_page = @site_home_page.click_text_converter
    end

    it 'converted text file is not empty' do
      @text_convert_page.upload_file(TestingSiteOnlyoffice::TestData.docx_path)
      extension = @text_convert_page.selected_format.downcase
      @text_convert_page.bypass_captcha
      @text_convert_page.convert_button_click
      @text_convert_page.download_button_click
      expect(@text_convert_page).to be_file_downloaded(TestingSiteOnlyoffice::TestData.docx_path, extension)
    end

    it 'upload incorrect file format on text converter page' do
      @text_convert_page.upload_file(TestingSiteOnlyoffice::TestData.log_path)
      expect(@text_convert_page).to be_error_popup_appeared
    end

    it 'sign up link works on text converter page' do
      sign_up_page = @text_convert_page.sign_up_button_click
      expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
    end

    it 'conversion API link works on text converter page' do
      @text_convert_page.conversion_api_button_click
      expect(@text_convert_page.check_opened_page_title(switch_tab: false)).to eq('Online Text File Converter | ONLYOFFICE')
    end
  end

  describe 'spreadsheet conversion' do
    before do
      @spreadsheet_convert_page = @site_home_page.click_spreadsheets_converter
    end

    it 'converted spreadsheet file is not empty' do
      @spreadsheet_convert_page.upload_file(TestingSiteOnlyoffice::TestData.spreadsheet_path)
      extension = @spreadsheet_convert_page.selected_format.downcase
      @spreadsheet_convert_page.bypass_captcha
      @spreadsheet_convert_page.convert_button_click
      @spreadsheet_convert_page.download_button_click
      expect(@spreadsheet_convert_page).to be_file_downloaded(TestingSiteOnlyoffice::TestData.spreadsheet_path, extension)
    end

    it 'upload incorrect file format on spreadsheet converter page' do
      @spreadsheet_convert_page.upload_file(TestingSiteOnlyoffice::TestData.log_path)
      expect(@spreadsheet_convert_page).to be_error_popup_appeared
    end

    it 'sign up link works on spreadsheet converter page' do
      sign_up_page = @spreadsheet_convert_page.sign_up_button_click
      expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
    end

    it 'conversion API link works on spreadsheet converter page' do
      @spreadsheet_convert_page.conversion_api_button_click
      expect(@spreadsheet_convert_page.check_opened_page_title(switch_tab: false)).to eq('Online Spreadsheet Converter | ONLYOFFICE')
    end
  end

  describe 'presentation conversion' do
    before do
      @presentation_convert_page = @site_home_page.click_presentations_converter
    end

    it 'converted presentation file is not empty' do
      @presentation_convert_page.upload_file(TestingSiteOnlyoffice::TestData.presentation_path)
      extension = @presentation_convert_page.selected_format.downcase
      @presentation_convert_page.bypass_captcha
      @presentation_convert_page.convert_button_click
      @presentation_convert_page.download_button_click
      expect(@presentation_convert_page).to be_file_downloaded(TestingSiteOnlyoffice::TestData.presentation_path, extension)
    end

    it 'upload incorrect file format on presentation converter page' do
      @presentation_convert_page.upload_file(TestingSiteOnlyoffice::TestData.log_path)
      expect(@presentation_convert_page).to be_error_popup_appeared
    end

    it 'sign up link works on presentation converter page' do
      sign_up_page = @presentation_convert_page.sign_up_button_click
      expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
    end

    it 'conversion API link works on presentation converter page' do
      @presentation_convert_page.conversion_api_button_click
      expect(@presentation_convert_page.check_opened_page_title(switch_tab: false)).to eq('Online Presentation Converter | ONLYOFFICE')
    end
  end

  describe 'PDF conversion' do
    before do
      @pdf_convert_page = @site_home_page.click_PDFs_converter
    end

    it 'converted PDF file is not empty' do
      @pdf_convert_page.upload_file(TestingSiteOnlyoffice::TestData.pdf_path)
      extension = @pdf_convert_page.selected_format.downcase
      @pdf_convert_page.bypass_captcha
      @pdf_convert_page.convert_button_click
      @pdf_convert_page.download_button_click
      expect(@pdf_convert_page).to be_file_downloaded(TestingSiteOnlyoffice::TestData.pdf_path, extension)
    end

    it 'upload incorrect file format on PDF converter page' do
      @pdf_convert_page.upload_file(TestingSiteOnlyoffice::TestData.log_path)
      expect(@pdf_convert_page).to be_error_popup_appeared
    end

    it 'sign up link works on PDF converter page' do
      sign_up_page = @pdf_convert_page.sign_up_button_click
      expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
    end

    it 'conversion API link works on PDF converter page' do
      @pdf_convert_page.conversion_api_button_click
      expect(@pdf_convert_page.check_opened_page_title(switch_tab: false)).to eq('Online PDF Converter | ONLYOFFICE')
    end
  end
end
