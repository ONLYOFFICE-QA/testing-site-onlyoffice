# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative 'modules/site_pricing_helper'
require_relative 'modules/site_pricing_docs'

module TestingSiteOnlyoffice
  # Pricing for Onlyoffice Docs Developer edition
  # https://user-images.githubusercontent.com/67409742/146344533-6104101d-7965-4d00-8474-cd7182c4cc17.png
  class SitePriceDocsDeveloper
    include PageObject
    include SitePricingHelper
    include SiteToolbar
    include SitePriceDocs

    link(:get_quote_button, xpath: "//div[@class='dep-part ee-production ee-2']//a[contains(@data-id, 'ie-gaq')]")
    link(:free_button, xpath: '//div[@class="dep-part ee-production ee-2"]//div[@class="ee-text-part"]/a')
    div(:add_num_connection, xpath: '//div[@class="num-connections"]//div[@class="connections_increase simcon_change"]')
    div(:num_connections, xpath: '//div[@class="dep-part ee-production ee-2"]//div[@data-id="ie-number-updated"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { get_quote_button_present? }
    end

    def click_free_button
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(free_button_element) }
      free_button_element.click
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def fill_data_price_developer(number_connection, support_level)
      choose_number_connection(number_connection)
      choose_support_level(support_level)
    end

    def choose_number_connection(connection)
      add_num_connection_element.click while @instance.webdriver.get_text(num_connections_element) != connection
    end

    def get_quote_button_present?
      @instance.webdriver.element_present?(get_quote_button_element)
    end
  end
end
