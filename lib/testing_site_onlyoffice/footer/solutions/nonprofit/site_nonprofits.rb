# frozen_string_literal: true

require_relative 'site_request_free_cloud'
require_relative '../../../products/site_products_docs'
require_relative '../../../products/site_products_groups'
require_relative '../../../products/site_products_security'
require_relative '../../../products/connectors/site_products_connectors_onlyoffice'
require_relative '../../../get_onlyoffice/desktop_and_mobile/desktop/site_desktop_apps'
require_relative '../../../get_onlyoffice/modules/site_download_helper'

module TestingSiteOnlyoffice
  # /nonprofit-organizations.aspx
  # https://user-images.githubusercontent.com/40513035/101904951-b704ae00-3bc7-11eb-9787-a5deff0df8fc.png
  class SiteNonProfits
    include PageObject
    include SiteDownloadHelper

    div(:request_free_cloud_top, xpath: '//div[@id="godown"]')
    link(:request_free_cloud, xpath: '//a[@href="/free-cloud.aspx?from=nonprofit"]')

    link(:learn_more_about_editors, xpath: '//a[@href="/office-suite.aspx?from=nonprofit"]')
    link(:learn_more_about_collaboration_platforms, xpath: '//a[@href="/workspace.aspx?from=nonprofit"]')
    link(:learn_more_about_security, xpath: '//a[@href="/security.aspx?from=nonprofit"]')
    link(:nonprofit_download, xpath: '//a[@href="/download-desktop.aspx?from=nonprofit"]')
    link(:nonprofit_android, xpath: '//a[contains(@href,"play.google")]')
    link(:nonprofit_ios, xpath: '//a[contains(@href,"apps.apple")]')
    link(:see_all_integrations, xpath: '//a[@href="/all-connectors.aspx?from=nonprofit"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { request_free_cloud_element.present? }
    end

    def click_request_free_cloud
      request_free_cloud_element.click
      SiteRequestFreeCloud.new(@instance)
    end

    def click_learn_more_about_editors
      learn_more_about_editors_element.click
      SiteProductsDocs.new(@instance)
    end

    def click_learn_more_about_collaboration_platforms
      learn_more_about_collaboration_platforms_element.click
      SiteProductsWorkspace.new(@instance)
    end

    def click_learn_more_about_security
      learn_more_about_security_element.click
      SiteProductsSecurity.new(@instance)
    end

    def click_download
      nonprofit_download_element.click
      SiteDesktopApps.new(@instance)
    end

    def click_see_all_integrations
      see_all_integrations_element.click
      SiteProductsConnectorsOnlyoffice.new(@instance)
    end
  end
end
