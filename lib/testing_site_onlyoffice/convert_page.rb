# frozen_string_literal: true

require_relative 'site_helper'

module TestingSiteOnlyoffice
  # Handles operations with convert pages
  # /online-document-converter.aspx
  # /text-file-converter.aspx
  # /spreadsheet-converter.aspx
  # /presentation-converter.aspx
  # /pdf-converter.aspx
  # https://user-images.githubusercontent.com/38238032/188140519-e3b46efa-34a9-4aad-9802-3eb6ff32c68a.png
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/057adef8-4dba-44eb-aa18-5bbafa6a6239
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/a996ee07-eadd-4057-943d-55c48b0cc2e5
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/3b38ac98-13da-492e-8b10-993cebcaaa29
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/e2dba430-e51a-43f6-9bac-b5e8dbd2bada
  class ConvertPage
    include PageObject
    include SiteDownloadHelper

    file_field(:uploader, xpath: '//*[@id="fileInput"]')
    link(:select_file_button, xpath: '//*[@id="uploadNow"]')
    link(:convert_button, xpath: "//a[@id = 'convertNow']")
    link(:download_button, xpath: "//a[@id = 'downloadBtn']")
    link(:sign_up_button, xpath: "//p[contains(@class, 'sub_info_text')]/a")
    link(:conversion_api_button, xpath: "//a[contains(@href, '/editors/conversionapi')]")
    div(:convert_error_message, xpath: "//p[contains(text(), 'The file format is not supported.')]")
    div(:formats_button, xpath: "//div[contains(@class, 'output_select_btn')]")
    text_field(:email_hidden_field, id: 'emailInput')

    DOC_FORMATS = Set.new(%w[PDF PDFA DOCX DOCXF TXT RTF EPUB FB2 HTML DOCM DOTX DOTM ODT OTT PNG JPG BMP GIF]).freeze
    SPREADSHEET_FORMATS = Set.new(%w[PDF PDFA XLSX CSV ODS OTS XLTX XLTM XLSM PNG JPG BMP GIF]).freeze
    PRESENTATION_FORMATS = Set.new(%w[PDF PDFA PPTX ODP OTP POTX POTM PPTM PPSM PPSX PNG JPG BMP GIF]).freeze
    PDF_FORMATS = Set.new(%w[PDF PDFA DOCX DOCXF TXT RTF EPUB FB2 HTML DOCM DOTX DOTM ODT OTT PNG JPG BMP GIF]).freeze

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    # Wait page to load
    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(select_file_button_element) }
    end

    # Put the file path to the input field
    # @param [String] file_path path of the file to be uploaded
    def upload_file(file_path)
      self.uploader = file_path
    end

    # Bypasses captcha by making the email field visible and filling it with a predefined email address
    def bypass_captcha
      @instance.webdriver.execute_javascript("document.getElementById('emailInput').className = 'display';")
      email = SiteData::EMAIL_FOR_BYPASSING_CAPTCHA
      email_hidden_field_element.send_keys(email, :enter)
    end

    # Click on the available for conversion formats button
    def convert_formats_button_click
      @instance.webdriver.click_on_locator(formats_button_element)
    end

    # Get all available for conversion formats from the page
    # @return [Set<String>] set of formats
    def file_formats_list
      formats_xpath = "//div[contains(@class, 'output_items')]/div"
      formats_array = @instance.webdriver.get_text_of_several_elements(formats_xpath)
      formats_array.to_set
    end

    # Check whether popup with error message appeared or not
    # @return [Boolean] True if appeared and False if not
    def error_popup_appeared?
      @instance.webdriver.element_present?(convert_error_message_element)
    end

    # Get text of the format button
    # @return [String] format that is selected
    def selected_format
      @instance.webdriver.get_text(formats_button_element)
    end

    # Click on 'Convert' button
    def convert_button_click
      @instance.webdriver.click_on_locator(convert_button_element)
    end

    # Get the name of the converted file without extension
    # @return [String] basename of the converted file
    def converted_file_name
      converted_file_name_xpath = "//p[@id = 'outputFileName']"
      name_with_dot = @instance.webdriver.get_text(converted_file_name_xpath)
      File.basename(name_with_dot, '.*')
    end

    # Get the basename of the file from the file path
    # @return [String] basename of the file without extension
    def get_file_name(file_path)
      OnlyofficeFileHelper::FileHelper.filename_from_path(file_path, keep_extension: false)
    end

    # Check whether converted file is empty or not
    # @param [String] file_path file path to the file
    # @param [String] extension Expected extension of the converted file
    # @return [Boolean] True if converted file is not empty and False otherwise
    def file_downloaded?(file_path, extension)
      file_name = get_file_name(file_path)
      path_to_downloaded_file = "#{@instance.webdriver.download_directory}/#{file_name}.#{extension}"
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_file)
      downloaded_file_size = File.size(path_to_downloaded_file)
      downloaded_file_size >= 100
    end

    # Click on the 'Download' button
    def download_button_click
      @instance.webdriver.wait_until { download_button_present? }
      @instance.webdriver.click_on_locator(download_button_element)
    end

    # Check whether 'Download' button is visible on the page or not
    # @return [Boolean] True if visible and False otherwise
    def download_button_present?
      @instance.webdriver.element_present?(download_button_element)
    end

    # Click on the 'Sign UP' button
    def sign_up_button_click
      @instance.webdriver.click_on_locator(sign_up_button_element)
      SiteDocSpaceSignUp.new(@instance)
    end

    # Click on the 'Conversion API' button
    def conversion_api_button_click
      @instance.webdriver.click_on_locator(conversion_api_button_element)
    end
  end
end
