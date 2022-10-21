# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-android.aspx
  # https://user-images.githubusercontent.com/40513035/101054027-7e4a5080-3599-11eb-8a32-36765e3a202e.png
  class SiteFeaturesAndroid
    include PageObject
    include SiteToolbar

    link(:get_it_on_google,
         xpath: '//div[@class="officeformobilepage_header_buttons"]/a[contains(@href,"play.google")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(get_it_on_google_element) }
    end
  end
end
