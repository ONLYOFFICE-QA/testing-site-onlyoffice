# frozen_string_literal: true

require_relative 'site_docspace_sign_up'

module TestingSiteOnlyoffice
  # /docspace-signin.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/3db6224f-ed56-401e-b345-f4a84276aa5a date: 02/10/2023
  class SiteDocSpaceSignIn
    include PageObject

    button(:sign_in_button, xpath: '//input[@id = "signIn"]')
    text_field(:email, id: 'txtSignInEmail')
    text_field(:password, id: 'txtSignPassword')
    link(:register_sign_in, xpath: '//a[contains(@class, "registrationLink")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(sign_in_button_element) }
    end

    def register_from_sign_in
      register_sign_in_element.click
      SiteDocSpaceSignUp.new(@instance)
    end
  end
end
