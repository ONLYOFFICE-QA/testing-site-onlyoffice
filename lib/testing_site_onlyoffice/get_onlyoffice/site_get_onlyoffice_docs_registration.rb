# frozen_string_literal: true

module TestingSiteOnlyoffice

  # /docs-registration.aspx
  # https://user-images.githubusercontent.com/38238032/226367145-02686762-6975-42d8-aff0-766e6b063d7a.jpg
  class SiteGetOnlyofficeDocsRegistration
    include PageObject

    div(:docs_registration_form, xpath: "//div[contains(@class, 'DocsRegistrationFormPage')]")
    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(docs_registration_form_element) }
    end
  end
end

