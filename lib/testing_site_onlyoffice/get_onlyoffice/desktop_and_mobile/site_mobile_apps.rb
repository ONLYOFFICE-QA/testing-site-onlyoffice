# Download Mobile app
# https://user-images.githubusercontent.com/40513035/96514901-0b954800-126d-11eb-87e5-6928fc765ed3.png
require_relative 'modules/site_desktop_mobiles_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../../modules/site_toolbar'

module TestingSiteOnlyffice
  class SiteMobileApps
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar
    include SiteToolbarDesktopMobiles

    link(:site_mobile_google_play, xpath: '//a[contains(@href, "google")]')

    link(:site_mobile_app_store, xpath: '//a[contains(@href, "apple")]')
    link(:site_mobile_ios_whats_new, xpath: '//a[contains(@href, "apple")]/../..//a[contains(@href, "changelog")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        site_mobile_google_play_element.present?
      end
    end

    def download_links
      {
        mobile_android: site_mobile_google_play_element,
        mobile_ios: site_mobile_app_store_element
      }
    end
  end
end
