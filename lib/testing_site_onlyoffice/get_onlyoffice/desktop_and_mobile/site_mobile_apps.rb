# frozen_string_literal: true

require_relative 'modules/site_desktop_mobiles_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../../modules/site_toolbar'

module TestingSiteOnlyoffice
  # Download Mobile app
  # https://user-images.githubusercontent.com/40513035/116201991-f226fa00-a6ee-11eb-974e-274184565c65.png
  class SiteMobileApps
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar
    include SiteToolbarDesktopMobiles

    link(:site_mobile_google_play, xpath: '//a[contains(@href, "google")]')

    link(:site_mobile_appgallery, xpath: '//a[contains(@href, "appgallery")]')

    link(:site_mobile_app_store, xpath: '//a[contains(@href, "apple")]')
    link(:site_mobile_ios_whats_new, xpath: '//a[contains(@href, "apple")]/../..//a[contains(@href, "changelog")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(site_mobile_google_play_element)
      end
    end

    def download_links
      {
        mobile_android: site_mobile_google_play_element,
        mobile_ios: site_mobile_app_store_element
      }
    end

    def open_mobile_app_gallery
      site_mobile_appgallery_element.click
      sleep 10
    end
  end
end
