# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-suite.aspx
  # https://user-images.githubusercontent.com/40513035/131655305-0c37a9b9-8953-4443-a743-abda4caf2eb0.png
  class SiteProductsDocs
    include PageObject
    include SiteToolbar

    link(:run_on_your_own_server, xpath: '//div[@class="dp_header"]//a[contains(@href, "download.aspx")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(run_on_your_own_server_element) }
    end
  end
end
