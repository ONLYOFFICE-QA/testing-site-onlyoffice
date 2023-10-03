# frozen_string_literal: true

require_relative 'site_request_free_cloud'
require_relative '../../../features/site_features_docs'
require_relative '../../../features/site_features_security'
require_relative '../../../features/connectors/site_features_connectors_onlyoffice'
require_relative '../../../get_onlyoffice/desktop_and_mobile/desktop/site_get_onlyoffice_desktop_apps'
require_relative '../../../get_onlyoffice/modules/site_download_helper'

module TestingSiteOnlyoffice
  # /nonprofit-organizations.aspx
  # https://user-images.githubusercontent.com/40513035/101904951-b704ae00-3bc7-11eb-9787-a5deff0df8fc.png
  class SiteNonProfits
    include PageObject
    include SiteDownloadHelper

    div(:request_free_cloud_top, xpath: '//div[@id="godown"]')
    link(:request_free_cloud, xpath: '//a[@href="mailto:sales@onlyoffice.com?subject=Request%20a%20discount%20for%20a%20non-profit"]')

    link(:learn_more_about_docspace, xpath: "//a[@href='/docspace.aspx?from=nonprofit']")
    link(:docspace_registration, xpath: "//a[@href = '/docspace-registration.aspx' and text() = 'Try now']")
    link(:learn_more_about_collaboration_platforms, xpath: '//a[@href="/workspace.aspx?from=nonprofit"]')
    link(:learn_more_about_security, xpath: '//a[@href="/security.aspx?from=nonprofit"]')
    link(:nonprofit_download_workspace, xpath: "//a[@href='/download-workspace.aspx' and text() = 'Get it now']")
    link(:nonprofit_android, xpath: '//a[contains(@href,"play.google")]')
    link(:nonprofit_ios, xpath: '//a[contains(@href,"apps.apple")]')
    link(:see_all_integrations, xpath: '//a[@href="/all-connectors.aspx?from=nonprofit"]')
    link(:desktop_windows, xpath: '//a[contains(@class, "download_for_windows")]')
    link(:desktop_linux, xpath: '//a[contains(@class, "download_for_linux")]')
    link(:desktop_macos, xpath: '//a[contains(@class, "download_for_macos")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(request_free_cloud_element) }
    end

    def click_request_free_cloud
      request_free_cloud_element.click
      SiteRequestFreeCloud.new(@instance)
    end

    def click_learn_more_about_collaboration_platforms
      learn_more_about_collaboration_platforms_element.click
      SiteFeaturesWorkspace.new(@instance)
    end

    def click_learn_more_about_security
      learn_more_about_security_element.click
      SiteFeaturesSecurity.new(@instance)
    end

    def click_download_workspace
      nonprofit_download_workspace_element.click
      SiteGetOnlyofficeWorkspaceEnterprise.new(@instance)
    end

    def click_see_all_integrations
      see_all_integrations_element.click
      SiteFeaturesConnectorsOnlyoffice.new(@instance)
    end

    def click_learn_about_docspace
      learn_about_docspace_element_click
      SiteDocSpaceMainPage.new(@instance)
    end

    def click_docspace_registration
      docspace_registration_element.click
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_download_desktop(platform)
      @instance.webdriver.click_on_locator(send("desktop_#{platform}_element"))
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end
  end
end
