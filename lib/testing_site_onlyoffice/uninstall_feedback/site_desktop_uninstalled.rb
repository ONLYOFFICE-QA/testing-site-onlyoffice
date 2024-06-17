# frozen_string_literal: true

require_relative 'modules/site_uninstall_feedback_helper'

module TestingSiteOnlyoffice
  # /desktop-uninstalled.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/7d148086-8c00-4250-9cad-39d142477b68
  class SiteDesktopUninstalled
    include PageObject
    include SiteUninstallFeedbackHelper

    div(:install_canceled_form, xpath: '//div[@class = "ic_form"]')
    element(:technical_problems, xpath: '//input[@id="checkbox2"]/following-sibling::span')
    element(:another_desktop_software, xpath: '//input[@id="checkbox1"]/following-sibling::span')
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

    def select_all_options_desktop_uninstalled(technical_problems: false, another_desktop_software: false, necessary_features: false, legal_violation: false, rarely_use: false)
      technical_problems_element.click if technical_problems
      another_desktop_software_element.click if another_desktop_software
      necessary_features_element.click if necessary_features
      legal_violation_element.click if legal_violation
      rarely_use_element.click if rarely_use
    end

    def send_feedback_email_desktop_uninstalled
      select_all_options_desktop_uninstalled
      bypass_captcha_by_phrase
      click_send_feedback
    end
  end
end
