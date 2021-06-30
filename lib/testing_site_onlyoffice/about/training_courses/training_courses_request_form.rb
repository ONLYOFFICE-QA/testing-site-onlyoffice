# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Site training courses request form
  # https://user-images.githubusercontent.com/40513035/123755960-4b3b1780-d871-11eb-9ff6-baf6c9a3c66b.png
  class SiteTrainingCoursesRequestForm
    include PageObject

    text_field(:courses_full_name, xpath: "//input[@id='txtFirstName']")
    text_field(:courses_company_name, xpath: "//input[@id='txtCompanyName']")
    text_field(:courses_email, xpath: "//input[@id='txtEmail']")
    span(:courses_language, xpath: "//span[contains(@class, 'demoRFLangSelect')]")
    span(:courses_time_zone, xpath: "//span[contains(@class, 'demoRFTimeSelect')]")

    text_field(:submit_request, xpath: "//input[@id='requestButton']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { courses_time_zone_element.present? }
    end

    def send_training_courses_request(data = {})
      fill_training_courses_form(data)
      @instance.webdriver.wait_until { request_button_active? }
      submit_request_element.click
      @instance.webdriver.wait_until { request_accepted? }
    end

    def request_button_active?
      submit_request_element.attribute('class') == 'button red'
    end

    def request_accepted?
      submit_request_element.attribute('class').include?('succesfulReq')
    end

    def fill_training_courses_form(params = {})
      self.courses_full_name = params.fetch(:full_name, Faker::Name.name)
      self.courses_company_name = params.fetch(:company_name, "NCT Test #{Faker::Company.name}")
      self.courses_email = params.fetch(:email, SiteData::CLIENT_EMAIL)
      course_language = params.fetch(:language, 'en')
      change_course_language(course_language)
      time_zone = params.fetch(:time_zone, '-10:00')
      change_time_zone(time_zone)
    end

    def dropdown_element_xpath(language)
      "//li[@data-value='#{language}']"
    end

    def change_course_language(language)
      courses_language_element.click
      choose_dropdown_element(language)
    end

    def change_time_zone(zone)
      courses_time_zone_element.click
      choose_dropdown_element(zone)
    end

    def choose_dropdown_element(item_to_select)
      xpath = dropdown_element_xpath(item_to_select)
      @instance.webdriver.wait_until { @instance.webdriver.element_visible?(xpath) }
      @instance.webdriver.driver.find_element(:xpath, xpath).click
    end
  end
end
