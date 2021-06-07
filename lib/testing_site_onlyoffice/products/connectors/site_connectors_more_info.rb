# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Connectors info page constructor
  # https://user-images.githubusercontent.com/40513035/116677635-49320680-a95d-11eb-8465-2bce50e82df7.png
  class SiteConnectorsMoreInfo
    def initialize(instance, connector)
      @instance = instance
      @logo_xpath = "//div[contains(@class, '#{connector}_logo')]"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { logo_element_present? }
    end

    def logo_element_present?
      @instance.webdriver.get_element(@logo_xpath).present?
    end
  end
end
