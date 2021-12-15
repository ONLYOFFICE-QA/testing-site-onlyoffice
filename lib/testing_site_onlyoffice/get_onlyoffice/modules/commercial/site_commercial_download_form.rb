# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Form for commercial packages to get trial version
  # https://user-images.githubusercontent.com/40513035/99250896-81191780-281d-11eb-867a-e5cbd4e8fc6b.png
  class SiteCommercialDownloadForm
    include PageObject

    text_field(:full_name, xpath: '//input[@id="txtFirstName"]')
    text_field(:email, xpath: '//input[@id="txtEmail"]')
    text_field(:phone, xpath: '//input[@id="txtPhone"]')
    text_field(:company_name, xpath: '//input[@id="txtCompanyName"]')
    text_field(:company_website, xpath: '//input[@id="txtCompanyWebsite"]')

    text_field(:submit_request, xpath: '//input[@id="sbmtRequest"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(full_name_element)
      end
    end

    def send_trial_request(data = {})
      fill_commercial_download_form(data)
      @instance.webdriver.wait_until { get_it_now_button_active? }
      submit_request_element.click
      @instance.webdriver.wait_until { request_accepted? }
    end

    def get_it_now_button_active?
      submit_request_element.attribute('class') == 'button red'
    end

    def request_accepted?
      submit_request_element.attribute('class').include?('succesfulReq')
    end

    def fill_commercial_download_form(params = {})
      self.full_name = params.fetch(:full_name, Faker::Name.name)
      self.email = params.fetch(:email, SiteData::CLIENT_EMAIL)
      self.phone = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
      self.company_name = params.fetch(:company_name, Faker::Company.name)
      self.company_website = params.fetch(:site_url, Faker::Internet.domain_name)
    end
  end
end
