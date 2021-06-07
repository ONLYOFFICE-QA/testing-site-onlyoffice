# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative '../portal_helper/portal_main_page'

module TestingSiteOnlyoffice
  # Sign in page
  # https://user-images.githubusercontent.com/40513035/95858216-69a1c700-0d65-11eb-9255-5d2361a7d772.png
  class SiteSignIn
    attr_accessor :instance

    include PageObject
    include SiteToolbar

    # form sign in
    text_field(:email_sign_in, xpath: '//*[@id="txtSignInEmail"]')
    text_field(:password_sign_in, xpath: '//*[@id="txtSignPassword"]')
    link(:register_sign_in, xpath: '//a[@class = "registrationLink"]')
    link(:forgot_password_sign_in, xpath: '//*[@id="passRestorelink"]')
    element(:sign_in_button, xpath: '//*[@id="target"]//input[@type="button"]')
    div(:sign_in_error, xpath: '//div[@id="divSigninError"]')

    # restore password
    text_field(:email_forgot_password_sign_in, xpath: '//*[@id="passwordRestoreInput"]')
    button(:send_forgot_password_sign_in, xpath: '//*[@id="PasswordRestoreFinishButton"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        email_sign_in_visible?
      end
    end

    def email_sign_in_visible?
      email_sign_in_element.present?
    end

    def click_forgot_password_from_sign_in
      forgot_password_sign_in
      @instance.webdriver.wait_until do
        email_forgot_password_sign_in_element.present?
      end
    end

    def send_forgot_password(email)
      click_forgot_password_from_sign_in
      self.email_forgot_password_sign_in = email
      send_forgot_password_sign_in
      @instance.webdriver.wait_until 90 do
        !send_forgot_password_sign_in_element.present?
      end
    end

    def input_credentials(email, pwd)
      self.email_sign_in = email
      self.password_sign_in = pwd
    end

    def sign_in(email, pwd)
      input_credentials(email, pwd)
      sign_in_button_element.click
      return if sign_in_error_element.present?

      @instance.webdriver.wait_until(100) { !email_sign_in_element.present? }
      PortalMainPage.new(@instance)
    end

    def register_from_sign_in
      register_sign_in_element.click
      SiteSignUp.new(@instance)
    end
  end
end
