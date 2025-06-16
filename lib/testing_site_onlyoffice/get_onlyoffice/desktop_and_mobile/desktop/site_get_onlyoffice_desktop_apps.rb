# frozen_string_literal: true

require_relative 'site_desktop_constructor'
require_relative '../modules/site_desktop_mobiles_toolbar'
require_relative '../../modules/site_download_helper'
require_relative '../../modules/site_block_constructor_helper'
require_relative '../../../modules/site_toolbar'

module TestingSiteOnlyoffice
  # /download-desktop.aspx
  # https://user-images.githubusercontent.com/40513035/96171228-4aee2c80-0f2d-11eb-80f9-5be447890300.png
  class SiteGetOnlyofficeDesktopApps
    include PageObject
    include SiteBlockConstructorHelper
    include SiteDownloadHelper
    include SiteToolbarDesktopMobiles
    include SiteToolbar

    div(:desktop_editor_installer_block, xpath: "//div[@class='dwn-mp-desktop']//div[@class='dwn-mp-item']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        mac_download_xpath = desktop_installer_block.download_xpath
        @instance.webdriver.element_present?(mac_download_xpath)
      end
    end

    def desktop_editor_installer_block_number
      @instance.webdriver.driver.find_elements(:xpath, desktop_editor_installer_block_element.selector[:xpath]).count
    end

    def desktop_installer_block(type = :mac)
      SiteDesktopConstructor.new(@instance, type.to_s)
    end

    def click_learn_more_on_website(id)
      site_link_xpath = "//a[@id='#{id}']"
      @instance.webdriver.click_on_locator(site_link_xpath)
    end
  end
end
