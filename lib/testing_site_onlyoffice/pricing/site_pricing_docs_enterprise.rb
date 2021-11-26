# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative 'modules/site_pricing_helper'

module TestingSiteOnlyoffice
  # Pricing for Onlyoffice Docs Enterprice edition
  # https://user-images.githubusercontent.com/40513035/100147949-1adf6500-2ead-11eb-8a68-1f477922c777.png
  class SitePriceDocsEnterprise
    include PageObject
    include SitePricingHelper
    include SiteToolbar

    link(:buy_now_single_server, xpath: '//div[@class="ee-calculator-part"]//a[@data-id="ie-price-url-updated"]')
    link(:buy_now_home_server, xpath: '//div[@class="ee-text-part"]/a[@class="button red"]')

    link(:try_free_button, xpath: '//div[@class="dep-part ee-business"]//div[@class="ee-text-part"]/a')
    link(:ready_editing_tools_button, xpath: '//div[@class="ee-text-part"]/ul[@class="pp_features_list"]/li/a')
    div(:home_tariff, xpath: '//div[@data-id="ee-home"]')
    div(:num_connections, xpath: '//div[@class="num-connections"]//div[@data-id="ie-number-updated"]')
    div(:add_num_connections, xpath: '//div[@class="num-connections"]//div[@class="pp_connections_increase simcon_change"]')
    div(:support_basic, xpath: '//div[@class = "ee-calculator-part"]//div[@data-id="basic_support"]')
    div(:support_plus, xpath: '//div[@class = "ee-calculator-part"]//div[@data-id="plus_support"]')
    div(:support_premium, xpath: '//div[@class = "ee-calculator-part"]//div[@data-id="premium_support"]')
    span(:total_price, xpath: '//div[@class="total-price-amount"]//span[@class="pp_price_number"]')
    div(:total_price_upon_request, xpath: '//div[@class="total-price-amount"]//div[@data-id="ie-pp-sum-req"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        buy_now_single_server_element.present?
      end
    end

    def choose_support_level(support_level)
      choose_support_basic if support_level == 'Basic'
      choose_support_plus if support_level == 'Plus'
      choose_support_premium if support_level == 'Premium'
    end

    def choose_support_basic
      support_basic_element.click
      @instance.webdriver.wait_until do
        support_basic_element.attribute('class').include?('selected_sp')
      end
    end

    def choose_support_plus
      support_plus_element.click
      @instance.webdriver.wait_until do
        support_plus_element.attribute('class').include?('selected_sp')
      end
    end

    def choose_support_premium
      support_premium_element.click
      @instance.webdriver.wait_until do
        support_premium_element.attribute('class').include?('selected_sp')
      end
    end

    def choose_home_tariff
      home_tariff_element.click
    end

    def click_try_free_button
      @instance.webdriver.wait_until do
        try_free_button_element.present?
      end
      try_free_button_element.click
      SiteDocsEnterprise.new(@instance)
    end

    def click_ready_editing_tools_button
      @instance.webdriver.wait_until do
        ready_editing_tools_button_element.present?
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

    def total_price_number
      @instance.webdriver.get_text(total_price_element)
    end

    def total_price_upon_request
      @instance.webdriver.wait_until do
        total_price_upon_request_element.attribute('class').include?('pp_sum req')
      end
      @instance.webdriver.get_text(total_price_upon_request_element)
    end

    def fill_data_price_enterprise(number_connection, support_level)
      choose_number_connection(number_connection)
      choose_support_level(support_level)
    end
  end
end
