# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Handles operations with marketplace
  # /app-directory
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/0367d24e-56a3-461b-a14d-8cb3c9f54a00
  class SiteFeaturesMarketplace
    include PageObject

    element(:plugins_header, xpath: '//h3[text()="Plugins"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(plugins_header_element) }
    end
  end
end
