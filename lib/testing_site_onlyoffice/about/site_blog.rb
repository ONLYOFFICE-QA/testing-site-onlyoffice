# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /blog/
  # https://user-images.githubusercontent.com/40513035/101406576-af54b900-38ea-11eb-942d-ec817bad65cf.png
  class SiteBlog
    include PageObject
    include SiteToolbar

    link(:article_blog, xpath: '(//*[contains(@id,"post-")]//a)[1]|//div[contains(@class, "postThemeGridBox")]//a')
    elements(:desktop_mobile_app, xpath: '//div[@class="download-button"]/a')
    link(:google_play_button, xpath: '//div[@class="download-button"]/a[@class="download GooglePlay"]')
    link(:app_store_button, xpath: '//div[@class="download-button"]/a[@class="download AppStore"]')
    link(:windows_button, xpath: '//div[@class="download-button"]/a[@class="download winodws"]')
    link(:linux_button, xpath: '//div[@class="download-button"]/a[@class="download linux"]')
    link(:macos_button, xpath: '//div[@class="download-button"]/a[@class="download MacOs"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { article_blog_element.present? }
    end

    def desktop_and_mobile_app
      apps = desktop_mobile_app_elements.map { |app| app.attribute('class') }
      apps.map { |s| s.gsub('download ', '') }
    end

    def check_google_play_link
      google_play_button_element.click
      @instance.webdriver.switch_to_popup
      @instance.webdriver.get_url.include?('play.google.com')
    end

    def check_app_store_link
      app_store_button_element.click
      @instance.webdriver.switch_to_popup
      @instance.webdriver.get_url.include?('apps.apple.com')
    end

    def check_desktop_apps_link(apps)
      desktop = { windows: windows_button_element, linux: linux_button_element, macos: macos_button_element }
      desktop[apps].click
      @instance.webdriver.switch_to_popup
      SiteDesktopApps.new(@instance)
    end
  end
end
