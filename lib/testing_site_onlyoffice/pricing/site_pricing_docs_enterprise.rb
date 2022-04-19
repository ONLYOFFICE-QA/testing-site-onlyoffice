# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative 'modules/site_pricing_helper'
require_relative 'modules/site_pricing_docs'

module TestingSiteOnlyoffice
  # Pricing for Onlyoffice Docs Enterprice edition
  # https://user-images.githubusercontent.com/40513035/100147949-1adf6500-2ead-11eb-8a68-1f477922c777.png
  class SitePriceDocsEnterprise
    include PageObject
    include SitePricingHelper
    include SiteToolbar
    include SitePriceDocs

    link(:buy_now_single_server, xpath: '//div[@class="ee-calculator-part"]//a[@data-id="ie-price-url-updated"]')
    link(:buy_now_home_server, xpath: '//div[@class="ee-text-part"]/a[@class="button red"]')

    link(:try_free_button, xpath: '//div[@class="dep-part ee-business"]//div[@class="ee-text-part"]/a')
    link(:ready_editing_tools_button, xpath: '//div[@class="ee-text-part"]/ul[@class="pp_features_list"]/li/a')
    div(:home_tariff, xpath: '//div[@data-id="ee-home"]')
    div(:business_tariff, xpath: '//div[@data-id="ee-business"]')
    div(:num_connections, xpath: '//div[@class="num-connections"]//div[@data-id="ie-number-updated"]')
    div(:add_num_connections, xpath: '//div[@class="num-connections"]//div[@class="pp_connections_increase simcon_change"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(home_tariff_element)
      end
    end

    def choose_home_tariff
      home_tariff_element.click
    end

    def click_try_free_button
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(try_free_button_element)
      end
      try_free_button_element.click
      SiteDocsEnterprise.new(@instance)
    end

    def click_ready_editing_tools_button
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(ready_editing_tools_button_element)
      end
      ready_editing_tools_button_element.click
      SiteProductsEnterpriseEdition.new(@instance)
    end

    def choose_number_connection(connection)
      add_num_connections_element.click while num_connection != connection
    end

    def num_connection
      @instance.webdriver.get_text(num_connections_element)
    end

    def fill_data_price_enterprise(number_connection, support_level)
      choose_number_connection(number_connection)
      choose_support_level(support_level)
    end

    def check_active_tariff(tariff)
      return true if @instance.webdriver.get_attribute("//div[@data-id='ee-#{tariff}']", 'class').include?('active')
    end
  end
end
