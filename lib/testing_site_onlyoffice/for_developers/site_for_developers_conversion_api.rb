# frozen_string_literal: true

module TestingSiteOnlyoffice
  # conversion-api.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/06d9b47e-435f-42de-976a-5d3b5208191a
  class SiteForDevelopersConversionAPI
    include PageObject
    link(:get_started, xpath: "//a[contains(@class, 'button') and contains(@href, 'api.onlyoffice.com')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(get_started_element)
      end
    end
  end
end
