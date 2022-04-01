# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /webinars.aspx
  # https://user-images.githubusercontent.com/67409742/161224198-c0699f69-a13d-4464-8f5d-af30409bf9ad.png
  class SiteWebinars
    include PageObject

    element(:webinars, xpath: '//div[@class="nwp_header_narrow max-width-1"]')
    element(:webinars_heder, xpath: '//div[@class="nwp_header_narrow max-width-1"]/h1/b')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(webinars_element) }
      return true if @instance.webdriver.get_text(webinars_heder_element) == 'webinars'

      @instance.webdriver.webdriver_error("The page 'Webinars' didn't load or doesn't match the title")
    end
  end
end
