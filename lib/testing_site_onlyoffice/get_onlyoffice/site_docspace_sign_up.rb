# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /docspace-registration.aspx
  # https://user-images.githubusercontent.com/38238032/234256489-08d104ea-ceed-4735-a394-e30fd991bb2f.jpg
  class SiteDocSpaceSignUp
    include PageObject
    include SiteDownloadHelper

    div(:sign_up_form, xpath: "//div[contains(@class, 'signuppageform')]")
    div(:portal_region, xpath: "//div[contains(@class, 'signUpBaseDomainValue')]")

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

    def fill_out_form(params)
      self.first_name = params.custom_user_list[0].first_name
      self.last_name = params.custom_user_list[0].last_name
      self.email = params.custom_user_list[0].mail
      self.phone = Faker::PhoneNumber.cell_phone_in_e164
      self.portal_name = params.portal_name
      self.password = params.custom_user_list[0].password
    end

    def click_signup_submit
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(submit_button_element) }
      @instance.webdriver.click_on_locator(submit_button_element)
    end

    def complete_registration_form(params)
      fill_out_form(params)
      click_signup_submit
    end
  end
end
