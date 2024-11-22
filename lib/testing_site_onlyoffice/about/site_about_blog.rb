# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /blog/
  # https://user-images.githubusercontent.com/40513035/101406576-af54b900-38ea-11eb-942d-ec817bad65cf.png
  class SiteAboutBlog
    include PageObject
    include SiteToolbar

    download_block_xpath = "//div[@class='download-block-btns']"
    div(:article_blog, xpath: '//div[contains(@class, "main-post")]')
    elements(:desktop_mobile_app, xpath: "#{download_block_xpath}/a/span")
    link(:google_play_button, xpath: "#{download_block_xpath}/a[contains(@class, 'download-block-btn google-play')]")
    link(:app_store_button, xpath: "#{download_block_xpath}/a[contains(@class, 'download-block-btn app-store')]")
    link(:windows_button, xpath: "//a[contains(@class, 'oo-fm-apps-item--windows')]")
    link(:linux_button, xpath: "//a[contains(@class, 'oo-fm-apps-item--linux')]")
    link(:macos_button, xpath: "//a[contains(@class, 'oo-fm-apps-item--macos')]")
    element(:create_account_window, xpath: '//*[contains(text(), "ONLYOFFICE account")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?("//div[contains(@class, 'docspace_block_icons')]") }
    end

    def desktop_and_mobile_app
      desktop_mobile_app_elements.map(&:text)
    end

    def check_google_play_link
      google_play_button_element.click
      @instance.webdriver.switch_to_popup
      @instance.webdriver.current_url.include?('play.google.com')
    end

    def check_app_store_link
      app_store_button_element.click
      @instance.webdriver.switch_to_popup
      @instance.webdriver.current_url.include?('apps.apple.com')
    end

    def go_to_desktop_apps(apps)
      desktop = { windows: windows_button_element, linux: linux_button_element, macos: macos_button_element }
      desktop[apps].click
      @instance.webdriver.switch_to_popup
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end
  end
end
