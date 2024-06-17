# frozen_string_literal: true

require_relative 'modules/site_uninstall_feedback_helper'

module TestingSiteOnlyoffice
  # /install-canceled.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/a9dcf6ac-e902-468d-87ad-93a453d628ab
  class SiteInstallCanceledPage
    include PageObject
    include SiteUninstallFeedbackHelper

    div(:install_canceled_form, xpath: '//div[@class = "ic_form"]')
    element(:cloud_version, xpath: '//input[@id="checkbox1"]/following-sibling::span')
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

    def select_all_options_install_canceled(cloud_version: false, technical_problems: false, necessary_features: false, legal_violation: false, rarely_use: false)
      cloud_version_element.click if cloud_version
      technical_problems_element.click if technical_problems
      necessary_features_element.click if necessary_features
      legal_violation_element.click if legal_violation
      rarely_use_element.click if rarely_use
    end

    def send_feedback_email_install_canceled
      select_all_options_install_canceled
      bypass_captcha_by_phrase
      enter_client_email
      click_send_feedback
    end
  end
end
