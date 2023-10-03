# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative '../portal_helper/portal_main_page'
require_relative '../additional_products/sign_in/sign_in_with'

module TestingSiteOnlyoffice
  # Sign in page
  # https://user-images.githubusercontent.com/40513035/95858216-69a1c700-0d65-11eb-9255-5d2361a7d772.png
  class SiteGetOnlyofficeSignIn
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
      @instance.webdriver.element_present?(email_sign_in_element)
    end

    def click_forgot_password_from_sign_in
      forgot_password_sign_in
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(email_forgot_password_sign_in_element)
      end
    end

    def send_forgot_password(email)
      click_forgot_password_from_sign_in
      self.email_forgot_password_sign_in = email
      send_forgot_password_sign_in
      @instance.webdriver.wait_until 90 do
        !@instance.webdriver.element_present?(send_forgot_password_sign_in_element)
      end
    end

    def input_credentials(email, pwd)
      self.email_sign_in = email
      self.password_sign_in = pwd
    end

    def sign_in(email, pwd)
      input_credentials(email, pwd)
      sign_in_button_element.click
      return if @instance.webdriver.element_present?(sign_in_error_element)

      @instance.webdriver.wait_until(100) { !@instance.webdriver.element_present?(email_sign_in_element) }
      PortalMainPage.new(@instance)
    end

    def register_from_sign_in
      register_sign_in_element.click
      SiteDocSpaceSignUp.new(@instance)
    end

    def sign_in_with(network)
      network_xpath = "//a[@class='popup #{network}']"
      @instance.webdriver.driver.find_element(:xpath, network_xpath).click
      @instance.webdriver.choose_tab(2)
      SignInWith.new(@instance, network)
    end
  end
end
