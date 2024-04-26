# frozen_string_literal: true

require_relative '../modules/site_editors_xpath'

module TestingSiteOnlyoffice
  # /form-creator.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/53475320/eb029258-6e31-44e5-add1-2327186b5d09
  class SiteFeaturesFormCreator
    include PageObject
    include SiteEditorsXpath
    include SiteToolbar

    link(:open_library, xpath: "//article//a[contains(@href, 'oforms.onlyoffice.com')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        open_library = @instance.webdriver.element_present?(open_library_element)
        button_present = @instance.webdriver.element_present?(docspace_registration_button_element) ||
                         @instance.webdriver.element_present?(docs_get_it_now_button_element)
        open_library && button_present
      end
    end
  end
end
