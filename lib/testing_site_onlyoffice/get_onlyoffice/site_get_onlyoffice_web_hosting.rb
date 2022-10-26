# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /hosting-providers.aspx
  # https://user-images.githubusercontent.com/38238032/197181815-4744c402-62a8-4504-abc2-48d4a6a356b8.png
  class SiteGetOnlyofficeWebHosting
    include PageObject
    include SiteToolbar

    link(:docs_enterprise_link, xpath: '//a[@id = "linkid_docs_ee"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(docs_enterprise_link_element)
      end
    end
  end
end
