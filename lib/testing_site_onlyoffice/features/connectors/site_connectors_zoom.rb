# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-zoom.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/14c3b590-da17-4226-8b1b-119996279667
  class SiteConnectorsZoom
    include PageObject

    link(:add_to_zoom, xpath: '(//a[@class = "button zoom_btn"])[1]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(add_to_zoom_element) }
    end
  end
end
