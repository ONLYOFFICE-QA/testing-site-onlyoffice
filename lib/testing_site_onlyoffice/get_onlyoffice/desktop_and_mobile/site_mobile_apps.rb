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

    link(:oo_documents_google_play, xpath: '//a[@id="onlyoffice_documents_for_android"]')
    link(:oo_documents_appgallery, xpath: '//a[@id="onlyoffice_documents_for_huawei_app_gallery"]')
    link(:oo_documents_app_store, xpath: '//a[@id="onlyoffice_documents_for_ios"]')
    link(:oo_documents_galaxy_store, xpath: '//a[@id="onlyoffice_documents_for_galaxy_store"]')
    link(:oo_documents_ios_whats_new, xpath: '//a[contains(@href, "apple")]/../..//a[contains(@href, "changelog")]')

    link(:oo_projects_google_play, xpath: '//a[@id="onlyoffice_projects_for_android"]')
    link(:oo_projects_app_store, xpath: '//a[@id="onlyoffice_projects_for_ios"]')
    link(:oo_projects_appgallery, xpath: '//a[@id="onlyoffice_projects_for_huawei_app_gallery"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(oo_documents_google_play_element)
      end
    end

    def download_links
      {
        mobile_android: oo_documents_google_play_element,
        mobile_ios: oo_documents_app_store_element
      }
    end

    def open_mobile_app_gallery
      oo_documents_appgallery_element.click
      sleep 10
    end
  end
end
