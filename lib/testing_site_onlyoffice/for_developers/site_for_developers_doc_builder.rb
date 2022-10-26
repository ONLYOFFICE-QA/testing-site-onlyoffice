# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /document-builder.aspx
  # https://user-images.githubusercontent.com/38238032/197171586-bdfe6a84-7673-47ee-8675-8c5b0390bca0.png
  class SiteForDevelopersDocBuilder
    include PageObject
    include SiteToolbar

    link(:code_download_link, xpath: '//a[contains(@class, "code_download_link")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(code_download_link_element)
      end
    end
  end
end
