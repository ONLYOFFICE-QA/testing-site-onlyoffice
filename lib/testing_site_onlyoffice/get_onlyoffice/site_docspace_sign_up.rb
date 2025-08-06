# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /docspace-registration.aspx
  # https://user-images.githubusercontent.com/38238032/234256489-08d104ea-ceed-4735-a394-e30fd991bb2f.jpg
  class SiteDocSpaceSignUp
    include PageObject
    include SiteDownloadHelper

    div(:sign_up_form, xpath: "//div[contains(@class, 'DocspaceRegistrationForm')]")
    div(:portal_region, xpath: "//div[contains(@class, 'signUpBaseDomainValue')]")
    element(:aws_region, xpath: "//span[contains(@class, 'signUpAwsRegionSelect')]")
    element(:sign_up_with_email_text, xpath: "//div[normalize-space(text())='or sign up with email']")
    link(:sign_in_from_register_page, xpath: '//a[@id = "toSignIn"]')

    text_field(:first_name, xpath: "//input[@id = 'txtSignUpFirstName']")
    text_field(:last_name, xpath: "//input[@id = 'txtSignUpLastName']")
    text_field(:email, xpath: "//input[@id = 'txtEmail']")
    text_field(:phone, xpath: "//input[@id = 'txtPhone']")
    text_field(:portal_name, xpath: "//input[@id = 'txtSignUpPortalName']")
    text_field(:password, xpath: "//input[@id = 'txtSignUpPassword']")
    text_field(:submit_button, xpath: "//input[contains(@class, 'sbmtSignUp')]")

    link(:terms_and_conditions, xpath: '//a[contains(text(), "Terms and conditions")]')
    link(:privacy_statement, xpath: '//a[contains(text(), "Privacy statement")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(sign_up_form_element) }
    end

    def fill_out_form
      self.first_name = Faker::Name.first_name
      self.last_name = Faker::Name.last_name
      self.email = 'client@qamail.teamlab.info'
      self.portal_name = "#{Faker::Internet.domain_word}-portal"
      self.password = Faker::Internet.password(min_length: 8)
    end

    def click_signup_submit
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(submit_button_element) }
      @instance.webdriver.click_on_locator(submit_button_element)
    end

    def complete_registration_form
      fill_out_form
      click_signup_submit
      DocSpaceMainPage.new(@instance)
    end

    def log_in_from_register_page
      sign_in_from_register_page_element.click
      SiteDocSpaceSignIn.new(@instance)
    end

    def complete_email_field
      self.email = 'partners@qamail.teamlab.info'
      # click on a field to activate submit button
      sign_up_with_email_text_element.click
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(submit_button_element) }
      @instance.webdriver.click_on_locator(submit_button_element)
    end

    def click_create_new_account
      @instance.webdriver.wait_until(20) do
        @instance.webdriver.element_present?("//a[text()='Create new account']")
      end
      @instance.webdriver.click_on_locator("//a[text()='Create new account']")
      DocSpaceMainPage.new(@instance)
    end
  end
end
