# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative 'site_doсs_registration_page/site_docs_registration_data'
require_relative '../../additional_products/payment/stripe_payment_page'

module TestingSiteOnlyoffice
  # /docs-registration.aspx
  # https://user-images.githubusercontent.com/67409742/140712725-92ea25c1-8bec-4ff9-9445-a667f208b501.png
  class DocsRegistrationPage
    include PageObject
    include SiteToolbar

    # form sign in
    text_field(:doc_full_name, xpath: '//*[@class="txtFirstName"]')
    text_field(:doc_email, xpath: '//input[contains(@class,"txtEmail")]')
    text_field(:doc_phone, xpath: '//input[@id="txtPhone"]')
    text_field(:submit_request, xpath: '//input[@id="sbmtRequest"]')

    # Errors
    div(:doc_full_name_error, xpath: '//div[@class="error txtFirstName_errorArea"]')
    div(:doc_email_error, xpath: '//div[@class="error txtEmail_errorArea"]')
    div(:doc_phone_error, xpath: '//div[@class="error txtPhone_errorArea"]')
    element(:log_in_link, xpath: '//a[@id = "toSignIn"]')

    # Terms
    link(:doc_privacy_statement, xpath: '//a[contains(text(), "Privacy statement")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(doc_full_name_element)
      end
    end

    def submit_correct_data(registration_data)
      submit_data(registration_data)
      StripePaymentPage.new(@instance)
    end

    def submit_data(registration_data)
      self.doc_full_name = registration_data.full_name
      self.doc_email = registration_data.doc_email
      # Press :enter in the doc_email field to activate the submit_request button
      doc_email_element.send_keys(:enter)
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(submit_request_element)
      end
      submit_request_element.click
    end

    def all_errors_visible?
      @instance.webdriver.element_present?(doc_full_name_error_element) & @instance.webdriver.element_present?(doc_email_error_element)
    end

    def open_login_page_from_registration_page
      log_in_link_element.click
      SiteDocsSignInPage.new(@instance)
    end
  end
end
