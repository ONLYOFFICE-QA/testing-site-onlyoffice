# frozen_string_literal: true

require_relative 'site_helper'

module TestingSiteOnlyoffice

  # Handles operations with convert page
  # /convert.aspx
  # https://user-images.githubusercontent.com/38238032/188140519-e3b46efa-34a9-4aad-9802-3eb6ff32c68a.png
  class ConvertPage
    include PageObject

    file_field(:uploader, xpath: '//*[@id="fileInput"]')

    def initialize(instance)
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

    def upload_file(file_path)
      self.uploader = file_path
    end
  end
end
