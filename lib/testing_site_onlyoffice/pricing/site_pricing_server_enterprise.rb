# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative 'modules/site_pricing_helper'
require_relative 'modules/site_pricing_docspace_toolbar'

module TestingSiteOnlyoffice
  # Pricing for Enterprice edition
  # https://user-images.githubusercontent.com/40513035/99254413-62b61a80-2823-11eb-8eb2-d68a48e32e2f.png
  class SitePriceServerEnterprise
    include PageObject
    include SitePricingHelper
    include SiteToolbar

    link(:buy_now_enterprise_plus, xpath: '//a[@class="button red standartBuyButton"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(buy_now_enterprise_plus_element)
      end
    end
  end
end
