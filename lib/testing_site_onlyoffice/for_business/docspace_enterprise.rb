# frozen_string_literal: true

require_relative '../pricing/modules/site_pricing_helper'
require_relative '../get_onlyoffice/site_docspace_sign_up'
require_relative '../get_onlyoffice/site_docspace_download_enterprise'
require_relative '../get_onlyoffice/desktop_and_mobile/desktop/site_get_onlyoffice_desktop_apps'
require_relative '../get_onlyoffice/desktop_and_mobile/site_mobile_apps'
require_relative '../features/site_features_security'
require_relative '../pricing/site_pricing_docspace_prices'

module TestingSiteOnlyoffice
  # /docspace-enterprise.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/100dc621-8e53-49fc-afbf-1153f3508771 date: 02/11/2023
  class SiteDocSpaceEnterprise
    include PageObject
    include SitePricingHelper

    CHOICE_XPATH = '//div[@class = "choice"]'
    link(:try_in_cloud_button, xpath: '//a[contains(@id, "try-it-free-in-the-cloud")]')
    link(:get_it_now_button, xpath: '//a[contains(@id, "try-it-free-in-the-cloud")]/preceding-sibling::a')
    link(:desktop_apps, xpath: '//a[contains(@href, "/download-desktop.aspx#desktop")]')
    link(:mobile_apps, xpath: '//a[contains(@href, "/download-desktop.aspx#mobile")]')
    link(:security_link, xpath: '//div[contains(@class, "security")]//a')
    link(:download_link_cloud, xpath: "#{CHOICE_XPATH}//a[@href = '/docspace-registration.aspx']")
    link(:download_link_linux, xpath: "#{CHOICE_XPATH}//a[@href = '/download-docspace.aspx'][1]")
    link(:download_link_windows, xpath: "#{CHOICE_XPATH}//a[@href = '/download-docspace.aspx'][2]")
    link(:enterprise_plan_link, xpath: '//div[@class = "dep-part ee-business"]/preceding-sibling::div/a')
    link(:pick_price_link, xpath: '//div[@class = "ds-item"]/a')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
    end

    def wait_to_load
      @instance.webdriver.wait_until { try_in_cloud_button_element }
    end

    def click_try_in_cloud
      try_in_cloud_button_element.click
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_get_it_now
      get_it_now_button_element.click
      SiteDocSpaceDownloadEnterprise.new(@instance)
    end

    def click_desktop_apps
      desktop_apps_element.click
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end

    def click_mobile_apps
      mobile_apps_element.click
      SiteMobileApps.new(@instance)
    end

    def click_security
      security_link_element.click
      SiteFeaturesSecurity.new(@instance)
    end

    def click_download_link_cloud
      download_link_cloud_element.click
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_download_link_linux
      download_link_linux_element.click
      SiteDocSpaceDownloadEnterprise.new(@instance)
    end

    def click_download_link_windows
      download_link_windows_element.click
      SiteDocSpaceDownloadEnterprise.new(@instance)
    end

    def click_enterprise_plan
      enterprise_plan_link_element.click
      SitePricingDocSpacePrices.new(@instance)
    end

    def click_pick_price_link
      pick_price_link_element.click
      SitePricingDocSpacePrices.new(@instance)
    end
  end
end
