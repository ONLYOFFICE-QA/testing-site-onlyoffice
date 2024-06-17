# frozen_string_literal: true

require_relative 'modules/site_uninstall_feedback_helper'

module TestingSiteOnlyoffice
  # /account-canceled.aspx
  # # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/74ff17b8-12a7-420c-91fc-6c9469ddd006
  class SiteAccountCanceled

    include PageObject
    include SiteUninstallFeedbackHelper

    div(:install_canceled_form, xpath: '//div[@class = "ic_form"]')
    element(:technical_problems, xpath: '//input[@id="checkbox2"]/following-sibling::span')
    element(:storage_space, xpath: '//input[@id="checkbox1"]/following-sibling::span')
    element(:necessary_features, xpath: '//input[@id="checkbox3"]/following-sibling::span')
    element(:legal_violation, xpath: '//input[@id="checkbox4"]/following-sibling::span')
    element(:rarely_work, xpath: '//input[@id="checkbox5"]/following-sibling::span')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(install_canceled_form_element) }
    end

    def select_all_options_account_canceled(technical_problems: false, storage_space: false, necessary_features: false, legal_violation: false, rarely_work: false)
      technical_problems_element.click if technical_problems
      storage_space_element.click if storage_space
      necessary_features_element.click if necessary_features
      legal_violation_element.click if legal_violation
      rarely_work_element.click if rarely_work
    end

    def send_feedback_email_account_canceled
      select_all_options_account_canceled
      bypass_captcha_by_phrase
      enter_client_email
      click_send_feedback
    end
  end
end
