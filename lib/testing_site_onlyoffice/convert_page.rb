# frozen_string_literal: true

require_relative 'site_helper'

module TestingSiteOnlyoffice
  # Handles operations with convert page
  # /online-document-converter.aspx
  # https://user-images.githubusercontent.com/38238032/188140519-e3b46efa-34a9-4aad-9802-3eb6ff32c68a.png
  class ConvertPage
    include PageObject

    file_field(:uploader, xpath: '//*[@id="fileInput"]')
    text_field(:email_hidden_field, id: 'emailInput')

    DOC_FORMATS = Set.new(%w[PDF PDFA DOCX DOCXF TXT RTF EPUB FB2 HTML DOCM DOTX DOTM ODT OTT PNG JPG BMP GIF]).freeze
    SPREADSHEET_FORMATS = Set.new(%w[PDF PDFA XLSX CSV ODS OTS XLTX XLTM XLSM PNG JPG BMP GIF]).freeze
    PRESENTATION_FORMATS = Set.new(%w[PDF PDFA PPTX ODP OTP POTX POTM PPTM PPSM PPSX PNG JPG BMP GIF]).freeze
    PDF_FORMATS = Set.new(%w[PDF PDFA DOCX DOCXF TXT RTF EPUB FB2 HTML DOCM DOTX DOTM ODT OTT PNG JPG BMP GIF]).freeze

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      @file_input_field_xpath = '//*[@id="fileInput"]'
      @convert_error_message_xpath = "//p[contains(text(), 'The file format is not supported.')]"
      @formats_button_xpath = "//div[contains(@class, 'output_select_btn')]"
      @convert_button_xpath = "//a[@id = 'convertNow']"
      @download_button_xpath = "//a[@id = 'downloadBtn']"
      wait_to_load
    end

    # Wait page to load
    def wait_to_load
      @instance.webdriver.wait_until { file_input_present? }
    end

    # Check if Input field is present on the page
    def file_input_present?
      @instance.webdriver.element_present?(@file_input_field_xpath)
    end

    # Put the file path to the input field
    # @param [String] file_path path of the file to be uploaded
    def upload_file(file_path)
      self.uploader = file_path
    end

    # Uses JavaScript to change the element's class, making it visible for bypassing captcha
    def show_email_field
      @instance.webdriver.execute_javascript("document.getElementById('emailInput').className = 'display';")
    end

    # Sends a predefined email address and simulates pressing the Enter key for bypassing captcha
    def send_email
      email = SiteData::EMAIL_FOR_BYPASSING_CAPTCHA
      email_hidden_field_element.send_keys(email, :enter)
    end

    # Click on the available for conversion formats button
    def convert_formats_button_click
      @instance.webdriver.click_on_locator(@formats_button_xpath)
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
      error_popup_xpath = "//div[contains(@class, 'error_popup')]/p[text() = 'The file format is not supported.']"
      @instance.webdriver.element_visible?(error_popup_xpath)
    end

    # Get text of the format button
    # @return [String] format that is selected
    def selected_format
      @instance.webdriver.get_text(@formats_button_xpath)
    end

    # Click on 'Convert' button
    def convert_button_click
      @instance.webdriver.click_on_locator(@convert_button_xpath)
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
    # @return [Boolean] True if converted file is not empty and False otherwise
    def file_downloaded?(file_path)
      file_name = get_file_name(file_path)
      path_to_downloaded_file = "#{@instance.webdriver.download_directory}/#{file_name}.pdf"
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_file)
      downloaded_file_size = File.size(path_to_downloaded_file)
      downloaded_file_size >= 100
    end

    # Click on the 'Download' button
    def download_button_click
      @instance.webdriver.wait_until { download_button_visible? }
      @instance.webdriver.click_on_locator(@download_button_xpath)
    end

    # Check whether 'Download' button is visible on the page or not
    # @return [Boolean] True if visible and False otherwise
    def download_button_visible?
      @instance.webdriver.element_visible?(@download_button_xpath)
    end
  end
end
