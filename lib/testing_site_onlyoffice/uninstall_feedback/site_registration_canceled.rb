# frozen_string_literal: true

require_relative 'modules/site_uninstall_feedback_helper'

module TestingSiteOnlyoffice
  # /registration-canceled.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/db574321-3332-4a8a-8f78-3b1628dd4bb8
  class SiteRegistrationCanceled
    include PageObject
    include SiteUninstallFeedbackHelper

    div(:install_canceled_form, xpath: '//div[@class = "ic_form"]')
    element(:switched_on_premises, xpath: '//input[@id="checkbox1"]/following-sibling::span')
    element(:switched_to_personal, xpath: '//input[@id="checkbox7"]/following-sibling::span')
    element(:technical_problems, xpath: '//input[@id="checkbox2"]/following-sibling::span')
    element(:necessary_features, xpath: '//input[@id="checkbox3"]/following-sibling::span')
    element(:legal_violation, xpath: '//input[@id="checkbox4"]/following-sibling::span')
    element(:rarely_use, xpath: '//input[@id="checkbox5"]/following-sibling::span')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(install_canceled_form_element) }
    end

    def select_all_options_registration_canceled(options = {})
      switched_on_premises_element.click if options[:switched_on_premises]
      switched_to_personal_element.click if options[:switched_to_personal]
      technical_problems_element.click if options[:technical_problems]
      necessary_features_element.click if options[:necessary_features]
      legal_violation_element.click if options[:legal_violation]
      rarely_use_element.click if options[:rarely_use]
    end

    def send_feedback_email_registration_canceled
      select_all_options_registration_canceled
      bypass_captcha_by_phrase
      enter_client_email
      click_send_feedback
    end
  end
end
