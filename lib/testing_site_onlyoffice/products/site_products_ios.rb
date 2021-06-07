# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-ios.aspx
  # https://user-images.githubusercontent.com/40513035/101085696-dcd6f500-35c0-11eb-9dae-0bef4df40372.png
  class SiteProductsIos
    include PageObject
    include SiteToolbar

    link(:download_on_the_app_store,
         xpath: '//div[@class="officeformobilepage_header_buttons"]/a[contains(@href,"itunes")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { download_on_the_app_store_element.present? }
    end
  end
end
