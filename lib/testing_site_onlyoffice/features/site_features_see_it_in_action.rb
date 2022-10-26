# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /see-it-in-action.aspx
  # https://user-images.githubusercontent.com/38238032/196722350-772d31ee-ef58-4876-b52d-07f1cc622fb1.png
  class SiteFeaturesSeeItInAction
    include PageObject
    include SiteToolbar

    link(:demo_preview, xpath: '//a[contains(@class, "example_source")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    # @todo: Change method to wait for editor loading instead of link
    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(demo_preview_element)
      end
    end
  end
end
