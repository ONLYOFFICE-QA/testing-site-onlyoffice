# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /personal.onlyoffice.com
  # https://user-images.githubusercontent.com/67409742/160410768-038c7c81-9097-4cc7-9e2f-bb88f512a150.png
  class SiteRequirePersonalCloud
    include PageObject
    include SiteToolbar

    link(:login, xpath: "//a[contains(@href,'/sign-in')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(login_element) }
    end
  end
end
