# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /collaboration-platform.aspx
  # https://user-images.githubusercontent.com/40513035/101089919-e6fbf200-35c6-11eb-99e6-b82c727dda22.png
  class SiteProductsGroups
    include PageObject
    include SiteToolbar

    link(:run_on_your_own_server,
         xpath: '//div[@class="workplacepage_header_content"]/a[contains(@href,"/download.aspx")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { run_on_your_own_server_element.present? }
    end
  end
end
