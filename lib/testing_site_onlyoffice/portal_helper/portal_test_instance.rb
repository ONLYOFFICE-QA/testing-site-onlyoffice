module TestingSiteOnlyoffice
  class PortalTestInstance
    attr_accessor :webdriver

    def initialize(config, portal_url)
      @webdriver = WebDriver.new(config.browser, record_video: false)
      @webdriver.open(portal_url)
    end
  end
end
