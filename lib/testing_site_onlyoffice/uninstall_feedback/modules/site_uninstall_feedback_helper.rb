# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper methods for testing uninstall feedback pages
  module SiteUninstallFeedbackHelper
    include PageObject

    text_area(:message_field, xpath: '//textarea[@id="nctautotest-ignore-captcha"]')
    text_field(:email_field, xpath: '//input[@id="txtEmail"]')
    button(:send_feedback_button, xpath: '//input[@id="sbmtRequest"]')
    link(:sla_link, xpath: '//a[contains(text(), "SLA")]')
    link(:privacy_statement, xpath: '//a[contains(text(), "Privacy statement")]')

    def bypass_captcha_by_phrase
      message_field_element.send_keys('nctautotest-ignore-captcha')
    end

    def enter_client_email
      email_field_element.send_keys(TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL)
    end

    def click_send_feedback
      send_feedback_button_element.click
    end

    def click_sla_link
      sla_link_element.click
    end

    def click_privacy_statement
      privacy_statement_element.click
    end
  end
end
