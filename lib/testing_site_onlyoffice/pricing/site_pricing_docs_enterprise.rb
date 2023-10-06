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

    link(:buy_now_home_server, xpath: '//div[@class="ee-text-part"]/a[@class="button red"]')

    link(:try_free_button, xpath: '//div[@class="dep-part ee-business"]//div[@class="ee-text-part"]/a')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(try_free_button_element)
      end
    end

    def click_try_free_button
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(try_free_button_element)
      end
      try_free_button_element.click
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def check_active_tariff?(tariff)
      return true if @instance.webdriver.get_attribute("//div[@data-id='ee-#{tariff}']", 'class').include?('active')
    end
  end
end
