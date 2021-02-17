require_relative '../../Studio/TopToolbar'

module TestingSiteOnlyoffice
  class PortalWizardFirstPage
    include PageObject
    include TopToolbar

    text_field(:password, xpath: '//*[@id="newPwd"]')
    text_field(:repeat_password, xpath: '//*[@id="confPwd"]')

    select_list(:language, xpath: '//*[@id="studio_lng"]')
    select_list(:time_zone, xpath: '//*[@id="studio_timezone"]')
    text_field(:promo_code, xpath: '//*[@id="promocode_input"]')
    text_field(:new_email, xpath: '//*[@id="newEmailAddress"]')

    button(:save, xpath: '//*[@id="saveSettingsBtn"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def refresh
      @instance.webdriver.refresh
      wait_to_load
    end

    def wait_to_load
      OnlyofficeLoggerHelper.log('Opening wizard page...')
      sleep 30 if %i[opera firefox].include?(@instance.webdriver.browser)
      @instance.webdriver.wait_until(60) do
        password_element.present?
      end
    end

    def input_password(password = SettingsData::PORTAL_PASSWORD)
      sleep 1
      OnlyofficeLoggerHelper.log('Wizard: Input Password')
      self.password = password
      self.repeat_password = password
    rescue Selenium::WebDriver::Error::UnknownError
      OnlyofficeLoggerHelper.log('Failed to intput password')
    end

    def input_one_password_and_try_to_save(password = SettingsData::PORTAL_PASSWORD)
      self.password = password
      save
    rescue Selenium::WebDriver::Error::UnknownError
      OnlyofficeLoggerHelper.log('Failed to intput password')
    end

    def input_email(email)
      self.new_email = email
    end

    def promo_code?
      promo_code_element.present?
    end

    def next_page
      OnlyofficeLoggerHelper.log('Wizard: Click Save Button')
      save
      MainPage.new(@instance)
    end

    def get_languages_list
      @instance.webdriver.get_all_combo_box_values(language_xpath)
    end

    def set_language(lang_code)
      @instance.webdriver.select_combo_box(language_xpath, lang_code)
      StaticDataTeamLab.set_current_language(lang_code)
    end

    def set_time_zone(time_zone)
      @instance.webdriver.select_combo_box(time_zone_xpath, time_zone)
    end
  end
end
