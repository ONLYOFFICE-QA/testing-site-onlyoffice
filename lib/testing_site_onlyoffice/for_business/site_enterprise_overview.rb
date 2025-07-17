# frozen_string_literal: true

require_relative 'site_for_business_docs_enterprise_edition'
require_relative 'modules/site_enterprise_helper'

module TestingSiteOnlyoffice
  # for-enterprises.aspx
  # https://user-images.githubusercontent.com/38238032/233962616-6ebf0024-1da6-4335-91cf-77ae686e6317.jpg
  class SiteEnterpriseOverview
    include PageObject
    include SiteEnterpriseHelper

    link(:docspace_learn_more_link, xpath: '//a[@href = "/docspace.aspx?from=for-enterprises"]')
    link(:docspace_use_for_free_link, xpath: "//div[@class='es_block_buttons']/a[@href='/docspace-registration.aspx?from=for-enterprises']")
    link(:docspace_run_on_your_server, xpath: "//div[@class='es_block_buttons']/a[@href='/download-docspace.aspx#docspace-enterprise']")
    link(:docs_enterprise_link, xpath: '//a[@href = "/docs-enterprise.aspx?from=for-enterprises"]')
    link(:docs_download_now_link, xpath: '//a[@href = "/download-desktop.aspx#desktop"]')
    link(:docs_learn_more_link, xpath: '//a[@href = "/docs-enterprise.aspx?from=for-enterprises"]')
    link(:docs_see_prices_link, xpath: '//a[@href = "/docs-enterprise-prices.aspx?from=for-enterprises"]')
    link(:workspace_try_now_link, xpath: '//a[@href = "/download-workspace.aspx#workspace-enterprise"]')
    link(:workspace_see_prices_link, xpath: '//a[@href = "/workspace-prices.aspx?from=for-enterprises"]')
    link(:workspace_learn_more_link, xpath: '//a[@href = "/workspace-enterprise.aspx?from=for-enterprises"]')
    link(:desktop_download_now, xpath: '//a[@href = "/download-desktop.aspx#desktop"]')
    link(:desktop_learn_more, xpath: '//a[@href = "/desktop.aspx?from=for-enterprises"]')
    link(:mobile_download_now, xpath: '//a[@href = "/download-desktop.aspx#mobile"]')
    link(:mobile_ios_learn_more, xpath: '//a[@href = "/office-for-ios.aspx?from=for-enterprises"]')
    link(:mobile_android_learn_more, xpath: '//a[@href = "/office-for-android.aspx?from=for-enterprises"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(docspace_learn_more_link_element) }
    end
  end
end
