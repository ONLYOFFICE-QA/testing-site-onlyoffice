# frozen_string_literal: true

require_relative 'modules/site_pricing_helper'
require_relative '../additional_products/payment/avangate'
require_relative '../get_onlyoffice/site_docspace_sign_up'

module TestingSiteOnlyoffice
  # /docspace-prices.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/a0ad3480-af4d-4422-9476-67c88acbc0e2 date: 13/11/2023
  class SitePricingDocSpacePrices
    include PageObject
    include SitePricingHelper

    link(:try_free_button, xpath: '(//a[contains(@href, "/docspace-registration.aspx") and contains(text(), "Start now")])[1]')
    link(:docspace_on_premises, xpath: '//a[contains(@class, "docspace-on-premises")]')
    link(:startup_cloud_button, xpath: '//div[@class = "pp_button"]/a')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(try_free_button_element) }
    end

    def click_try_free_button
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(try_free_button_element)
      end
      try_free_button_element.click
      SiteDocSpaceDownloadEnterprise.new(@instance)
    end

    def click_enterprise_on_premises
      docspace_on_premises_element.click
    end

    def click_startup_cloud
      startup_cloud_button_element.click
      SiteDocSpaceSignUp.new(@instance)
    end
  end
end
