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

    div(:professional_support_basic, xpath: '//div[@class="ee-calculator-part"]//div[@class="support_switchers"]//div[@data-id="basic_support"]')
    link(:try_free_button, xpath: '//div[@class="dep-part ee-business"]//div[@class="ee-text-part"]/a')
    link(:ready_editing_tools_button, xpath: '//div[@class="ee-text-part"]/ul[@class="pp_features_list"]/li/a')

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

    def choose_support_basic
      professional_support_basic_element.click
      @instance.webdriver.wait_until do
        professional_support_basic_element.attribute('class').include?('selected_sp')
      end
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
  end
end
