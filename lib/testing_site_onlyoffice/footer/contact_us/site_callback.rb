# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /call-back-form.aspx
  # # https://cloud.githubusercontent.com/assets/18173785/22292502/a5427aec-e31c-11e6-90e9-49d0b18621c7.png
  class SiteCallback
    include PageObject
    include SiteToolbar

    text_field(:first_name, xpath: '//input[contains(@class,"FirstName")]')
    text_field(:last_name, xpath: '//input[contains(@class,"LastName")]')
    text_field(:email, xpath: '//input[contains(@class,"Email")]')
    text_field(:phone, xpath: '//input[contains(@class,"Phone")]')
    button(:date_button, xpath: '//button[contains(@class, "datepicker-trigger ")]')
    elements(:active_calendar_days, xpath: '//td[@data-handler="selectDay"]')
    elements(:timezones, xpath: '//div[@class = "timezone"]//li')
    elements(:hours, xpath: '//div[@class = "time"]//li')
    text_field(:submit, xpath: '//input[contains(@class,"sbmtCallbackForm")]')
    text_field(:congratulation, xpath: '//*[@id="callbackRequestAddSuccess"]//input')
    span(:next_month, xpath: '//span[@class="ui-icon ui-icon-circle-triangle-e"]')
    span(:calendar, xpath: '//span[@class="ui-datepicker-month"]')
    link(:select_button, xpath: '//a[@id = "selectbtn"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(first_name_element) }
    end

    def send_callback_request(data)
      fill_form(data)
      click_first_active_day
      OnlyofficeLoggerHelper.sleep_and_log('Waiting for closing calendar form', 1)
      submit_element.click
      @instance.webdriver.wait_until { congratulation_visible? }
    end

    def fill_form(params = {})
      self.first_name = params.fetch(:first_name, Faker::Name.first_name)
      self.email = params.fetch(:email, SiteData::EMAIL_ADMIN)
      self.phone = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
    end

    def congratulation_visible?
      @instance.webdriver.element_present?(congratulation_element)
    end

    def wait_calendar_visible?
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(calendar_element)
      end
    end

    def click_first_active_day
      date_button_element.click
      wait_calendar_visible?
      next_month_element.click
      active_calendar_days_elements.first.click
      timezones_elements.first.click
      hours_elements.first.click
      select_button_element.click
    end
  end
end
