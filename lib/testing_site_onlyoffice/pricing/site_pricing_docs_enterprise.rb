# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative 'modules/site_pricing_helper'
require_relative '../additional_products/payment/stripe_payment_page'

module TestingSiteOnlyoffice
  # Pricing for Onlyoffice Docs Enterprice edition
  # https://user-images.githubusercontent.com/40513035/100147949-1adf6500-2ead-11eb-8a68-1f477922c777.png
  class SitePriceDocsEnterprise
    include PageObject
    include SitePricingHelper
    include SiteToolbar

    link(:buy_now_home_server, xpath: '//div[@class="ee-text-part"]/a[@class="button red"]')
    link(:try_free_button, xpath: '//a[contains(@class, "not-shown-cloud")]')

    # Switch between cloud and on-premises
    div(:cloud, xpath: '//div[@data-id = "dd-cloud"]')
    div(:on_premises, xpath: '//div[@data-id = "dd-on-premises"]')

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
      true if @instance.webdriver.get_attribute("//div[@data-id='ee-#{tariff}']", 'class').include?('active')
    end

    def click_cloud
      cloud_element.click
    end

    def click_on_premises
      on_premises_element.click
    end
  end
end
