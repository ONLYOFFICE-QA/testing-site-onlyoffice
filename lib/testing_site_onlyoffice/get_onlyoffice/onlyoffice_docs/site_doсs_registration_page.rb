# frozen_string_literal: true

require_relative '../../modules/site_toolbar'

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

    def full_params(name, params = {})
      self.doc_first_name = name
      self.doc_last_name = params.fetch(:last_name, SiteData::DEFAULT_ADMIN_LASTNAME)
      self.doc_email = params.fetch(:email, SiteData::EMAIL_ADMIN)
      self.doc_phone = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
      @instance.webdriver.wait_until do
        submit_request_element.present?
      end
      submit_request_element.click
      @instance.webdriver.wait_until { request_accepted? }
    end

    def request_accepted?
      submit_request_element.attribute('class').include?('succesfulReq')
    end
  end
end
