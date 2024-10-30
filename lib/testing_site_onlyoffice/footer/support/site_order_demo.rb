# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /demo-order.aspx
  # https://user-images.githubusercontent.com/40513035/102109795-80d46200-3e45-11eb-87c7-e72f3297ee57.png
  class SiteOrderDemo
    include PageObject

    text_field(:first_name, xpath: '//input[contains(@class,"FirstName")]')
    text_field(:last_name, xpath: '//input[contains(@class,"LastName")]')
    text_field(:email, xpath: '//input[contains(@class,"Email")]')
    text_field(:phone, xpath: '//input[contains(@class,"Phone")]')
    text_field(:website, xpath: '//input[contains(@class,"txtWebsite")]')
    text_field(:company_name, xpath: '//input[contains(@class,"CompanyName")]')

    span(:onlyoffice_workspace, xpath: '//input[@id="ONLYOFFICE_Workspace"]/../span')
    span(:onlyoffice_docs, xpath: '//input[@id="ONLYOFFICE_Docs"]/../span')
    span(:onlyoffice_docspace, xpath: '//input[@id="ONLYOFFICE_DocSpace"]/../span')

    table(:select_time_field, xpath: '//table[@class= "timetable"]')
    span(:time_zone, id: 'tmzone')
    span(:demo_time, id: 'tm')
    link(:select, id: 'selectbtn')

    text_field(:send_request, xpath: '//input[@id="sendDemoRequest"]')
    span(:demonstration_language, xpath: '//span[contains(@class, "demoRFLangSelect")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(first_name_element) }
    end

    def send_demonstration_request(params = {})
      self.first_name = params.fetch(:first_name, Faker::Name.first_name)
      self.last_name = params.fetch(:last_name, Faker::Name.last_name)
      self.email = params.fetch(:email, SiteData::EMAIL_ADMIN)
      self.website = params.fetch(:website, "#{Faker::Internet.domain_word}.#{Faker::Internet.domain_suffix}")
      self.company_name = params.fetch(:company_name, Faker::Company.name)
      add_demo_time
      demonstration_language(params.fetch(:demonstration_language)) if @instance.webdriver.element_present?(demonstration_language_element)
      onlyoffice_workspace_element.click if params.fetch(:workspace_demo, true)
      onlyoffice_docs_element.click if params.fetch(:docs_demo, true)
      onlyoffice_docspace_element.click if params.fetch(:docspace_demo, true)
      @instance.webdriver.wait_until do
        !@instance.webdriver.get_attribute(send_request_element, 'class').include?('disable')
      end
      send_request_element.click
    end

    def demonstration_language(language)
      demonstration_language_element.click
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(dropdown_demonstration_language(language)) }
      dropdown_demonstration_language(language).click
    end

    def dropdown_demonstration_language(language)
      demonstration_language_xpath = "//li[@data-value='#{language}']"
      @instance.webdriver.get_element(demonstration_language_xpath)
    end

    def add_demo_time
      select_time_field_element.click
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(select_element) }
      @instance.webdriver.driver.find_element(:xpath, "(//li[@id='-10:00'])[1]").click
      @instance.webdriver.driver.find_element(:xpath, "//li[@id='1']").click
      select_element.click
    end
  end
end
