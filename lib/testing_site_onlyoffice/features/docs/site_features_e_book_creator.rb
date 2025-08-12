# frozen_string_literal: true

module TestingSiteOnlyoffice
  # e-book.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/fe7a5e76-766f-4896-87e0-c1ab52027b2c
  class SiteFeaturesEBookCreator
    include PageObject

    div(:documents_image, xpath: "//div[@class='oses_blocks_image e-book  ']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(documents_image_element)
      end
    end
  end
end
