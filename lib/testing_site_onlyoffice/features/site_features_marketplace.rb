# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Handles operations with marketplace
  # /app-directory
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/0367d24e-56a3-461b-a14d-8cb3c9f54a00
  class SiteFeaturesMarketplace
    include PageObject

    element(:all_plugins_filter, xpath: '//button[contains(@class, "filter-btn") and contains(., "plugins")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(all_plugins_filter_element) }
    end
  end
end
