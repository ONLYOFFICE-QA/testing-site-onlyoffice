# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative 'site_doсs_registration_page/site_docs_registration_data'

module TestingSiteOnlyoffice
  # /docs-registration.aspx
  # https://user-images.githubusercontent.com/67409742/140712725-92ea25c1-8bec-4ff9-9445-a667f208b501.png
  class DocsRegistrationPage
    include PageObject
    include SiteToolbar

    # form sign in
    text_field(:doc_first_name, xpath: '//*[@class="txtFirstName"]')
    text_field(:doc_last_name, xpath: '//*[@class="txtLastName"]')
    text_field(:doc_email, xpath: '//input[contains(@class,"txtEmail")]')
    text_field(:doc_phone, xpath: '//input[@id="txtPhone"]')
    text_field(:submit_request, xpath: '//input[@id="sbmtRequest"]')

    # Errors
    div(:doc_first_name_error, xpath: '//div[@class="error txtFirstName_errorArea"]')
    div(:doc_last_name_error, xpath: '//div[@class="error txtLastName_errorArea"]')
    div(:doc_email_error, xpath: '//div[@class="error txtEmail_errorArea"]')
    div(:doc_phone_error, xpath: '//div[@class="error txtPhone_errorArea"]')

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

    def fill_params(registration_data)
      registration_online_document(registration_data)
      @instance.webdriver.wait_until { request_accepted? }
    end

    def registration_online_document(registration_data)
      self.doc_first_name = registration_data.first_name
      self.doc_last_name = registration_data.last_name
      self.doc_email = registration_data.doc_email
      self.doc_phone = registration_data.doc_phone
      @instance.webdriver.wait_until do
        submit_request_element.present?
      end
      submit_request_element.click
    end

    def request_accepted?
      submit_request_element.attribute('class').include?('succesfulReq')
    end

    def any_errors_visible?
      doc_first_name_error_element.present? & doc_last_name_error_element.present? &
        doc_email_error_element.present? & doc_phone_error_element.present?
    end
  end
end
