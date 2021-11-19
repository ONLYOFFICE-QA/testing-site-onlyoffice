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
  end
end
