# frozen_string_literal: true

module TestingSiteOnlyoffice
  # https://oforms.onlyoffice.com
  # https://user-images.githubusercontent.com/38238032/196736104-45dbc113-c01a-4138-96d3-94685686b5c7.png
  class SiteFeaturesOforms
    include PageObject
    include SiteToolbar

    button(:forms_open_button, xpath: '//div[contains(@class, "box-info-content")]//button')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(forms_open_button_element)
      end
    end
  end
end
