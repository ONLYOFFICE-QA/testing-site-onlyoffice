# frozen_string_literal: true

require_relative '../modules/site_editors_xpath'

module TestingSiteOnlyoffice
  # /spreadsheet-editor.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/53475320/fddd303c-678d-44dc-8159-d277bf04db4e
  class SiteFeaturesSpreadsheetEditor
    include PageObject
    include SiteEditorsXpath
    include SiteToolbar

    link(:formulas_link, xpath: "//article//a[contains(@href, 'spreadsheet-editor/formulas-and-functions')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        formulas_link = @instance.webdriver.element_present?(formulas_link_element)
        button_present = @instance.webdriver.element_present?(docspace_registration_button_element) ||
                         @instance.webdriver.element_present?(docs_get_it_now_button_element)
        formulas_link && button_present
      end
    end
  end
end
