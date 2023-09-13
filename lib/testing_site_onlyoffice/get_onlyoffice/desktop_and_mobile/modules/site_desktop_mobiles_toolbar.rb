# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Desktop and mobiles top toolbar
  # https://user-images.githubusercontent.com/40513035/96172632-60645600-0f2f-11eb-8853-b6c348e7235d.png
  module SiteToolbarDesktopMobiles
    include PageObject

    div(:site_desktop_download, xpath: '//div[@id = "desktop"]')
    div(:site_mobile_download, xpath: '//div[@id = "mobile"]')

    def open_mobile_apps
      @instance.webdriver.execute_javascript("$('html, body').animate({ 'scrollTop': $('.btn-mobile').offset().top - topOffset }, 400)")
      sleep 2
      site_mobile_download_element.click
      SiteMobileApps.new(@instance)
    end

    def open_desktop_apps
      site_desktop_download_element.click
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end
  end
end
