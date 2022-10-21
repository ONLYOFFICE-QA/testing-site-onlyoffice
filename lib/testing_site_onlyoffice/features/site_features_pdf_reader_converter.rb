# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /pdf-reader.aspx
  # https://user-images.githubusercontent.com/38238032/196688860-a0e3bf90-d959-4e1c-8b26-e2d7de607e3a.png
  class SiteFeaturesPDFReaderConverter
    include PageObject
    include SiteToolbar

    link(:convert_link, xpath: '//a[@href = "/convert.aspx?from=pdfreader"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(convert_link_element)
      end
    end
  end
end
