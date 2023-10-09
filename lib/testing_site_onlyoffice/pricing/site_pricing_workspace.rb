# frozen_string_literal: true

require_relative '../get_onlyoffice/onlyoffice_workspace/site_get_onlyoffice_workspace_enterprise'

module TestingSiteOnlyoffice
  # /workspace-prices.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/9ce399ca-d8fe-4a64-83b8-b71e4ffba9d2
  class SitePricingWorkSpace
    include PageObject

    link(:try_free, xpath: '//a[contains(@href, "/download-workspace.aspx") and text() = "Try free for 30 days"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(try_free_element) }
    end

    def click_try_free
      try_free_element.click
      SiteGetOnlyofficeWorkspaceEnterprise.new(@instance)
    end
  end
end
