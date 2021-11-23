# frozen_string_literal: true

require_relative '../modules/site_editors_xpath'

module TestingSiteOnlyoffice
  # docs-enterprise.aspx?from=docs-enterprise-prices
  # https://user-images.githubusercontent.com/67409742/142990092-032280ef-b02f-4329-8fc8-78328ebd654f.png
  class SiteProductsEnterpriseEdition
    include PageObject

    div(:enterprise_edition, xpath: "//div[@id='forenterprises']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { enterprise_edition.present? }
    end
  end
end
