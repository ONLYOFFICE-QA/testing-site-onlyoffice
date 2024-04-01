# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Handles operations with plugin pages
  # /app-directory/plugin_name
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/08bc8b83-3918-4035-b163-9365cad27430
  class SiteMarketplacePluginPage
    include PageObject

    div(:tabs, xpath: '//div[@class = "tab-buttons"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(tabs_element) }
    end

    def current_plugin_page_title
      @instance.webdriver.title_of_current_tab
    end
  end
end
