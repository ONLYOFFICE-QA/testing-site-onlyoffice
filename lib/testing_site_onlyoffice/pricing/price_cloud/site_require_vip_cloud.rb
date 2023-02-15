# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /order.aspx
  # https://user-images.githubusercontent.com/40513035/115678858-d1cdf880-a306-11eb-9f0b-65613d52ebbd.png
  class SiteRequireVIPCloud
    include PageObject
    include SiteToolbar

    text_field(:full_name_vip, xpath: "//input[@id='txtFirstName']")
    text_field(:email_vip, xpath: "//input[@id='txtEmail']")
    text_field(:phone_vip, xpath: "//input[@id='txtPhone']")
    text_field(:company_name_vip, xpath: "//input[@id='txtCompanyName']")
    text_field(:employees_number_vip, xpath: "//input[@id='txtEmployeesCount']")
    text_field(:submit_vip_request, xpath: "//input[@id='sbmtRequest']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(full_name_vip_element) }
    end

    def fill_vip_request_fields(params = {})
      self.full_name_vip = params.fetch(:first_name, Faker::Name.first_name)
      self.email_vip = params.fetch(:email, SiteData::EMAIL_ADMIN)
      self.phone_vip = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
      self.company_name_vip = params.fetch(:company_name, Faker::Company.name)
      self.employees_number_vip = params.fetch(:employees_number, Random.new.rand(1...5000))
      click_on_comment
    end

    def submit_request_button_active?
      submit_vip_request_element.attribute('class') == 'button red'
    end

    def request_accepted?
      submit_vip_request_element.attribute('class').include?('succesfulReq')
    end

    def send_vip_cloud_request(params = {})
      fill_vip_request_fields(params)
      @instance.webdriver.wait_until { submit_request_button_active? }
      submit_vip_request_element.click
      @instance.webdriver.wait_until { request_accepted? }
    end
  end
end
