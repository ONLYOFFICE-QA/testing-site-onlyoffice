# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /cloud-office.aspx
  # https://user-images.githubusercontent.com/67409742/169787672-8d719c86-e351-4f0c-ae25-d764a2c009f9.png
  class SiteCloudEdition
    include PageObject

    div(:cloud_edition, xpath: "//div[@id='cloudofficepage']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(cloud_edition_element)
      end
    end
  end
end
