# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative '../portal_helper/portal_main_page'

module TestingSiteOnlyoffice
  # /registration.aspx
  # https://user-images.githubusercontent.com/40513035/130948402-3f673af1-84ee-47fc-a965-af672792e293.png
  class SiteSignUp
    include PageObject
    include SiteToolbar

    span(:server_region_dropdown,
         xpath: '//*[@class="dataItem dataItemHostingRegion"]//div[@class="styled-select-container"]//span')
    list_item(:server_region_us, xpath: '//*[@id="aspnetForm"]//span[contains(@class,"signUpBaseDomainSelect")]//li[1]')
    list_item(:server_region_eu, xpath: '//*[@id="aspnetForm"]//span[contains(@class,"signUpBaseDomainSelect")]//li[2]')
    list_item(:server_region_sg, xpath: '//*[@id="aspnetForm"]//span[contains(@class,"signUpBaseDomainSelect")]//li[3]')

    text_field(:first_name, xpath: '//*[@class="txtSignUpFirstName"]')
    text_field(:last_name, xpath: '//*[@class="txtSignUpLastName"]')
    text_field(:email, xpath: '//input[contains(@class,"txtSignUpEmail")]')
    text_field(:phone, xpath: '//input[@id="txtPhone"]')
    span(:number_of_users, xpath: '//span[contains(@class, "registNumberOfUsersSelect")]')
    text_field(:portal_name, xpath: '//input[contains(@class,"txtSignUpPortalName")]')
    text_field(:portal_password, xpath: '//input[contains(@class,"txtSignUpPassword")]')

    button(:start_trial, xpath: '//input[contains(@class,"sbmtSignUp")]')

    # Errors
    div(:first_name_error, xpath: '//div[@class="error txtSignUpFirstName_errorArea"]')
    div(:last_name_error, xpath: '//div[@class="error txtSignUpLastName_errorArea"]')
    div(:email_error, xpath: '//div[@class="error txtEmail_errorArea"]')
    div(:portal_name_error, xpath: '//div[@class="error txtSignUpPortalName_errorArea"]')
    div(:password_error, xpath: '//div[@class="error txtSignUpPassword_errorArea"]')

    # Terms
    link(:terms_and_conditions, xpath: '//a[contains(text(), "Terms and conditions")]')
    link(:privacy_statement, xpath: '//a[contains(text(), "Privacy statement")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        first_name_element.present?
      end
    end

    def show_regions_dropdown
      @instance.webdriver.execute_javascript("$('.dataItemHostingRegion').removeClass('display-none')")
    end

    def select_server_region(region)
      server_region_dropdown_element.click
      instance_eval("server_region_#{region}_element.click", __FILE__, __LINE__) # Choose appropriate region
    end

    def set_region(region)
      return unless config.server.include?('com')

      show_regions_dropdown
      region ||= config.region
      select_server_region(region)
    end

    def fill_data(params = {})
      fill_params(params)
      PortalMainPage.new(@instance)
    end

    def fill_params(params = {})
      self.first_name = params.fetch(:first_name, SiteData::DEFAULT_ADMIN_NAME)
      self.last_name = params.fetch(:last_name, SiteData::DEFAULT_ADMIN_LASTNAME)
      self.email = params.fetch(:email, SiteData::EMAIL_ADMIN)
      self.phone = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
      self.portal_name = params[:portal_name]
      self.portal_password = params.fetch(:password, SiteData::PORTAL_PASSWORD)
      set_number_of_users if number_of_users_element.present?
      set_region(params[:region])
      remove_recaptcha
      start_trial_element.click
    end

    def set_number_of_users(number = '1-3')
      number_of_users_element.click
      @instance.webdriver.wait_until { dropdown_user_number_element(number).present? }
      dropdown_user_number_element(number).click
    end

    def dropdown_user_number_element(number)
      user_number_xpath = "//li[@data-value='#{number}']"
      @instance.webdriver.get_element(user_number_xpath)
    end

    def all_errors_visible?
      first_name_error_element.present? & last_name_error_element.present? &
        email_error_element.present? & portal_name_error_element.present? & password_error_element.present?
    end

    def check_opened_file_name
      @instance.webdriver.choose_tab(2)
      @instance.init_online_documents
      @instance.doc_instance.management.wait_for_operation_with_round_status_canvas
      @instance.doc_instance.doc_editor.top_toolbar.title_row.document_name
    end

    private

    # According to Sergey.Linnik result of recaptcha is ignored
    # Sometimes captcha windows is overflow register button
    # This cause strange failures of test
    def remove_recaptcha
      @instance.webdriver.remove_element('//*[@id="recaptchaBlock"]')
    end
  end
end
