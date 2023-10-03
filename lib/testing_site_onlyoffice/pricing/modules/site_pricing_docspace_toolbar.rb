# frozen_string_literal: true

module TestingSiteOnlyoffice
  # DocSpace Pricing toolbar /docspace-prices.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/b38cd8d5-ac1f-467d-90cd-10451b49bdd9 date: 02/10/2023
  module SitePricingDocSpaceToolbar
    include PageObject

    div(:site_pricing_cloud, xpath: '//div[@id = "docspace-cloud"]')
    div(:site_pricing_enterprise, xpath: '//div[@id = "docspace-on-premises"]')

    def click_cloud
      site_pricing_cloud_element.click
      SitePricingCloud.new(@instance)
    end

    def click_enterprise
      site_pricing_enterprise_element.click
      SitePriceServerEnterprise.new(@instance)
    end
  end
end
