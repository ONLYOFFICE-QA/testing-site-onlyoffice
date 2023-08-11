# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Workspace Pricing toolbar /workspace-prices.aspx
  # https://user-images.githubusercontent.com/38238032/200322202-82868348-911d-491a-9a4f-03d7f9afe632.png
  module SitePricingWorkspaceToolbar
    include PageObject

    div(:site_pricing_cloud, xpath: '//div[@id = "workspace-cloud"]')
    div(:site_pricing_enterprise, xpath: '//div[@id = "workspace-on-premises"]')

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
