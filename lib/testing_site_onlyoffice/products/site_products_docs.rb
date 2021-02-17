# /office-suite.aspx
# https://user-images.githubusercontent.com/40513035/101088255-718f2200-35c4-11eb-9e24-ce43b069f4fb.png

module TestingSiteOnlyoffice
  class SiteProductsDocs
    include PageObject
    include SiteToolbar

    link(:run_on_your_own_server, xpath: '//a[@href="/download-commercial.aspx?from=office-suite"]')

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
