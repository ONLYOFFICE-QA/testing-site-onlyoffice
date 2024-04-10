# frozen_string_literal: true

require_relative 'site_docspace_sign_up'
require_relative '../portal_helper/docspace_main_page'

module TestingSiteOnlyoffice
  # /docspace-signin.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/3db6224f-ed56-401e-b345-f4a84276aa5a date: 02/10/2023
  class SiteDocSpaceSignIn
    include PageObject
    include SiteDownloadHelper

    button(:sign_in_button, xpath: '//input[@id = "signIn"]')
    text_field(:email, id: 'txtSignInEmail')
    text_field(:password, id: 'txtSignPassword')
    link(:register_sign_in, xpath: '//a[contains(@class, "registrationLink")]')

    # restore password elements
    link(:forgot_password, xpath: '//a[@id = "passRestorelink"]')
    text_field(:email_for_restoring_password, id: 'passwordRestoreInput')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(sign_in_button_element) }
    end

    def email_and_password_submit(email:, password:)
      email_element.send_keys(email)
      password_element.send_keys(password)
      sign_in_button_element.click
      DocSpaceMainPage.new(@instance)
    end

    def register_from_sign_in
      register_sign_in_element.click
      SiteDocSpaceSignUp.new(@instance)
    end

    def restore_password_from_sign_in(email)
      forgot_password_element.click
      email_for_restoring_password_element.send_keys(email, :enter)
    end
  end
end
