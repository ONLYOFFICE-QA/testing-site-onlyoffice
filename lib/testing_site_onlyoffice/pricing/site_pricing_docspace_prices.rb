# frozen_string_literal: true

require_relative 'modules/site_pricing_docspace_toolbar'
require_relative 'modules/site_pricing_helper'
module TestingSiteOnlyoffice
  # /docspace-prices.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/b6194c13-5062-4780-8af8-2b08135b9001 date: 02/10/2023
  class SitePricingDocSpacePrices
    include PageObject
    include SitePricingDocSpaceToolbar
    include SitePricingHelper

    div(:home_tariff, xpath: '//div[@data-id="ee-home"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(home_tariff_element) }
    end
  end
end
