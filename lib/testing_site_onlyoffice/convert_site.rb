# frozen_string_literal: true

require_relative 'site_helper'

module TestingSiteOnlyoffice
  #  Handles operations with convert page
  # https://user-images.githubusercontent.com/38238032/188140519-e3b46efa-34a9-4aad-9802-3eb6ff32c68a.png
  class ConvertSite
    def initialize(instance)
      @instance = instance
    end

    def file_input_present?
      file_input_xpath = '//*[@id="fileInput"]'
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(file_input_xpath)
      end
    end
  end
end
