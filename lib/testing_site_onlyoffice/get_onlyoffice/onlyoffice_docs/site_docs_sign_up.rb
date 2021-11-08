# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative '../../portal_helper/portal_main_page'

module TestingSiteOnlyoffice
  # /docx-registration.aspx
  # https://user-images.githubusercontent.com/67409742/140712725-92ea25c1-8bec-4ff9-9445-a667f208b501.png
  class SiteDocSignUp
    include PageObject
    include SiteToolbar

    # form sign in
    text_field(:doc_first_name, xpath: '//*[@class="txtFirstName"]')
    text_field(:doc_last_name, xpath: '//*[@class="txtLastName"]')
    text_field(:doc_email, xpath: '//input[contains(@class,"txtEmail")]')
    text_field(:doc_phone, xpath: '//input[@id="txtPhone"]')
    button(:start_trial, xpath: '//input[contains(@class,"disabled valid")]')

    # Errors
    div(:doc_first_name_error, xpath: '//div[@class="error txtFirstName_errorArea"]')
    div(:doc_last_name_error, xpath: '//div[@class="error txtLastName_errorArea"]')
    div(:doc_email_error, xpath: '//div[@class="error txtEmail_errorArea"]')

    # Terms
    link(:doc_privacy_statement, xpath: '//a[contains(text(), "Privacy statement")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        doc_first_name_element.present?
      end
    end
  end
end
