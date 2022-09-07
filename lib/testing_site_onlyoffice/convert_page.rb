# frozen_string_literal: true

require_relative 'site_helper'

module TestingSiteOnlyoffice
  # Handles operations with convert page
  # /convert.aspx
  # https://user-images.githubusercontent.com/38238032/188140519-e3b46efa-34a9-4aad-9802-3eb6ff32c68a.png
  class ConvertPage
    include PageObject

    file_field(:uploader, xpath: '//*[@id="fileInput"]')

    DOC_FORMATS = %w[docm docxf dotm dotx epub fb2 html odt ott pdf pdfa rtf txt].freeze
    SPREADSHEET_FORMATS = %w[csv ods ots pdf pdfa xlsm xltm xltx].freeze
    PRESENTATION_FORMATS = %w[odp otp pdf pdfa potm potx pptm].freeze

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      @file_input_field_xpath = '//*[@id="fileInput"]'
      @convert_error_message_xpath = "//p[contains(text(), 'The file format is not supported.')]"
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

    # Click on the available for conversion formats button
    def convert_formats_button_click
      formats_button_xpath = "//div[contains(@class, 'output_select_btn')]"
      @instance.webdriver.click_on_locator(formats_button_xpath)
    end

    # Get all available for conversion formats from the page
    # @return [Array<String>] array of formats
    def file_formats_list
      formats_xpath = "//div[contains(@class, 'output_items')]/div"
      @instance.webdriver.get_text_of_several_elements(formats_xpath)
    end

    # Check whether popup with error message appeared or not
    # @return [Boolean] True if appeared and False if not
    def error_popup_appeared?
      error_popup_xpath = "//div[contains(@class, 'error_popup')]/p[text() = 'The file format is not supported.']"
      @instance.webdriver.element_visible?(error_popup_xpath)
    end
  end
end
