# /demo-order.aspx
# https://user-images.githubusercontent.com/40513035/102109795-80d46200-3e45-11eb-87c7-e72f3297ee57.png

module TestingSiteOnlyoffice
  class SiteOrderDemo
    include PageObject

    text_field(:first_name, xpath: '//input[contains(@class,"FirstName")]')
    text_field(:last_name, xpath: '//input[contains(@class,"LastName")]')
    text_field(:email, xpath: '//input[contains(@class,"Email")]')
    text_field(:phone, xpath: '//input[contains(@class,"Phone")]')
    text_field(:website, xpath: '//input[contains(@class,"CompanyAddress")]')
    text_field(:company_name, xpath: '//input[contains(@class,"CompanyName")]')

    checkbox(:onlyoffice_groups, xpath: '//input[@id="ONLYOFFICE_Groups"]')
    checkbox(:onlyoffice_docs, xpath: '//input[@id="ONLYOFFICE_Docs"]')

    text_field(:send_request, xpath: '//input[@id="sendDemoRequest"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { first_name_element.present? }
    end

    def send_demonstration_request(params = {})
      self.first_name = params.fetch(:first_name, Faker::Name.first_name)
      self.last_name = params.fetch(:last_name, Faker::Name.last_name)
      self.email = params.fetch(:email, SettingsData::GMAIL)
      self.phone = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
      self.website = params.fetch(:website, Faker::Internet.domain_name)
      self.company_name = params.fetch(:company_name, Faker::Company.name)
      check_onlyoffice_groups if params.fetch(:docs_demo, true)
      check_onlyoffice_docs if params.fetch(:groups_demo, true)
      @instance.webdriver.wait_until do
        !@instance.webdriver.get_attribute(send_request_element, 'class').include?('disable')
      end
      send_request_element.click
      SiteHomePage.new(@instance)
    end
  end
end
