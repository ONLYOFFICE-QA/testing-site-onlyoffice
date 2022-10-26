# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /security.aspx
  # https://user-images.githubusercontent.com/40513035/102408701-08b19c00-3fff-11eb-80a6-8de52b3640cd.png
  class SiteFeaturesSecurity
    include PageObject

    div(:security_indicator, xpath: '//div[@class="sec-top-block"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(security_indicator_element) }
    end
  end
end
