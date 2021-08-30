# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative '../get_onlyoffice/modules/site_download_helper'
require_relative '../additional_products/personal_main_page'

module TestingSiteOnlyoffice
  # Solutions -> Home use page
  # https://user-images.githubusercontent.com/40513035/100807023-a3787b00-3442-11eb-933d-a119c3d902a4.png
  class SiteHomeUse
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar

    link(:download_now_desktop_editors, xpath: '//a[@href="/download-desktop.aspx?from=home-use"]')
    link(:learn_more_desktop_editors, xpath: '//a[@href="/desktop.aspx?from=home-use"]')

    link(:get_it_now_document_editors, xpath: '//div[@class="homeUse_features"]//a[@href="/download-commercial.aspx"]')
    link(:see_all_integrations, xpath: '//a[@href="/all-connectors.aspx?from=home-use"]')

    link(:download_workspace, xpath: '//a[@href="/download.aspx?from=home-use#bundles"]')
    link(:learn_more_workspace, xpath: '//a[@href="/workspace.aspx?from=home-use"]')

    link(:create_online_office, xpath: '//a[@href="https://personal.onlyoffice.com"]')

    link(:download_on_app_store, xpath: '//a[contains(@href, "apps.apple")]')
    link(:download_on_google_play, xpath: '//a[contains(@href, "play.google")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { download_now_desktop_editors_element.present? }
    end

    def download_desktop_editors
      download_now_desktop_editors_element.click
      SiteDesktopApps.new(@instance)
    end

    def click_learn_more_desktop_editors
      learn_more_desktop_editors_element.click
      SiteProductsDesktop.new(@instance)
    end

    def get_it_now_self_hosted_editors
      get_it_now_document_editors_element.click
      SiteCommercialDocs.new(@instance)
    end

    def click_see_all_integrations
      see_all_integrations_element.click
      SiteProductsConnectorsOnlyoffice.new(@instance)
    end

    def download_self_hosted_productivity_apps
      download_workspace_element.click
      SiteOtherProductsBundles.new(@instance)
    end

    def click_learn_more_hosted_productivity_apps
      learn_more_workspace_element.click
      SiteProductsWorkspace.new(@instance)
    end

    def open_personal
      create_online_office_element.click
      @instance.webdriver.choose_tab(2)
      PersonalMainPage.new(@instance)
    end

    def click_download_on_app_store
      download_on_app_store_element.click
      get_marketplace_title
    end

    def click_download_on_google_play
      download_on_google_play_element.click
      get_marketplace_title
    end

    def get_marketplace_title
      @instance.webdriver.wait_until { !download_now_desktop_editors_element.present? }
      @instance.webdriver.get_title_of_current_tab
    end
  end
end
