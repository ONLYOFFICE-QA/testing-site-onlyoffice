# frozen_string_literal: true

require_relative 'site_marketplace_plugin_page'

module TestingSiteOnlyoffice
  # Handles operations with plugins marketplace
  # /app-directory
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/0367d24e-56a3-461b-a14d-8cb3c9f54a00
  class SiteFeaturesMarketplace
    include PageObject
    include SiteDownloadHelper

    element(:search, xpath: '//input[contains(@class, "search-input")]')
    link(:visit_api_button, xpath: "//a[contains(@class, 'banner-btn') and contains(@class, 'external-link')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(search_element) }
    end

    def click_get_it_now(plugin_name)
      get_it_now_button_xpath = "//div[@class='card-box-text']//a[contains(@href, '/app-directory/#{plugin_name}')][2]"
      @instance.webdriver.click_on_locator(get_it_now_button_xpath)
      SiteMarketplacePluginPage.new(@instance)
    end

    def plugins_count
      plugin_card_xpath = "//div[@class='card-box-text']"
      @instance.webdriver.get_element_count(plugin_card_xpath)
    end

    def search_for_plugin_works?(plugin_name)
      initial_plugins_count = plugins_count
      search_element.send_keys(plugin_name, :enter)
      @instance.webdriver.wait_until { plugins_count < initial_plugins_count }
      result_xpath = "//div[@class='card-box-text']//a[contains(@href, '#{plugin_name}')]"
      @instance.webdriver.element_visible?(result_xpath)
    end

    def click_visit_api_button
      visit_api_button_element.click
    end
  end
end
