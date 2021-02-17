# https://cloud.githubusercontent.com/assets/18173785/22292502/a5427aec-e31c-11e6-90e9-49d0b18621c7.png
# /call-back-form.aspx
module TestingSiteOnlyoffice
  class SiteCallback
    include PageObject
    include SiteToolbar

    text_field(:first_name, xpath: '//input[contains(@class,"FirstName")]')
    text_field(:last_name, xpath: '//input[contains(@class,"LastName")]')
    text_field(:email, xpath: '//input[contains(@class,"Email")]')
    text_field(:phone, xpath: '//input[contains(@class,"Phone")]')
    text_field(:date, xpath: '//input[contains(@class,"Date")]')
    text_field(:time, xpath: '//input[contains(@class,"Time")]')
    elements(:active_calendar_days, xpath: '//td[@data-handler="selectDay"]')
    text_field(:submit, xpath: '//input[contains(@class,"sbmtCallbackForm")]')
    text_field(:congratulation, xpath: '//*[@id="callbackRequestAddSuccess"]//input')
    span(:next_month, xpath: '//span[@class="ui-icon ui-icon-circle-triangle-e"]')
    span(:calendar, xpath: '//span[@class="ui-datepicker-month"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { first_name_element.present? }
    end

    def send_callback_request(data)
      fill_form(data)
      click_first_active_day
      sleep 1 # wait for closing calendar form
      submit_element.click
      @instance.webdriver.wait_until { congratulation_visible? } unless StaticDataTeamLab.portal_type == '.com'
    end

    def fill_form(params = {})
      self.first_name = params.fetch(:first_name, Faker::Name.first_name)
      self.last_name = params.fetch(:last_name, Faker::Name.last_name)
      self.email = params.fetch(:email, SettingsData::GMAIL)
      self.phone = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
    end

    def congratulation_visible?
      congratulation_element.present?
    end

    def wait_calendar_visible?
      @instance.webdriver.wait_until do
        calendar_element.present?
      end
    end

    def click_first_active_day
      date_element.click
      wait_calendar_visible?
      next_month_element.click
      active_calendar_days_elements.first.click
    end
  end
end
