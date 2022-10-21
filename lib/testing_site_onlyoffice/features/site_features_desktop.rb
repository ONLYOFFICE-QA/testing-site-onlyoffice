# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Products & Features -> Onlyoffice for desktop
  # https://user-images.githubusercontent.com/40513035/100942880-2e25ac80-350d-11eb-8b46-3fbd44cd0d90.png
  class SiteFeaturesDesktop
    include PageObject
    include SiteToolbar

    link(:desktop_download_now, xpath: '//a[@href="/download-desktop.aspx?from=desktop" and @class="button red"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(desktop_download_now_element) }
    end
  end
end
