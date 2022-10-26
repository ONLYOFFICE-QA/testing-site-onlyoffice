# frozen_string_literal: true

module TestingSiteOnlyoffice
  # https://api.onlyoffice.com
  # https://user-images.githubusercontent.com/38238032/197167437-10ea5aa8-51d3-46f2-bc0c-89eb125dad1f.png
  class SiteForDevelopersApiDoc
    include PageObject
    include SiteToolbar

    link(:document_server_doc_link, xpath: '//div[contains(@class, "icon-program-block")]//a[@href = "/editors/basic"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(document_server_doc_link_element)
      end
    end
  end
end
