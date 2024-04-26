# frozen_string_literal: true

require_relative '../modules/site_editors_xpath'

module TestingSiteOnlyoffice
  # /presentation-editor.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/53475320/ff939181-4c96-4f78-bdb3-522143c506d3
  class SiteFeaturesPresentationEditor
    include PageObject
    include SiteEditorsXpath
    include SiteToolbar

    link(:transition_effects_link, xpath: "//article//a[contains(@href, 'presentation-editor/transition-effects')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        transition_effects_link = @instance.webdriver.element_present?(transition_effects_link_element)
        button_present = @instance.webdriver.element_present?(docspace_registration_button_element) ||
                         @instance.webdriver.element_present?(docs_get_it_now_button_element)
        transition_effects_link && button_present
      end
    end
  end
end
