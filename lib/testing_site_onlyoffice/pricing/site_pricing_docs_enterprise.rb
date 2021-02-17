# Pricing for Onlyoffice Docs Enterprice edition
# https://user-images.githubusercontent.com/40513035/100147949-1adf6500-2ead-11eb-8a68-1f477922c777.png
require_relative '../modules/site_toolbar'
require_relative 'modules/site_pricing_helper'

module TestingSiteOnlyoffice
  class SitePriceDocsEnterprise
    include PageObject
    include SitePricingHelper
    include SiteToolbar

    link(:buy_now_single_server, xpath: '//a[@id= "ie-price-url-updated"]')

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
  end
end
