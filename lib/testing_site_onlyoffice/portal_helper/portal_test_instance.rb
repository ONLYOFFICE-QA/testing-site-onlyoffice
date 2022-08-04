# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Portal instance parameters
  class PortalTestInstance
    attr_accessor :webdriver

    def initialize(config, portal_url)
      @webdriver = OnlyofficeWebdriverWrapper::WebDriver.new(config.browser, record_video: false)
      @webdriver.open(portal_url)
    end
  end
end
