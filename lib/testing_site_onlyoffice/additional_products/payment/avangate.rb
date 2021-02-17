# frozen_string_literal: true

require_relative 'data/payment_data'
module TestingSiteOnlyoffice
  class Avangate
    attr_accessor :instance

    include PageObject

    elements(:avangate_price_select, xpath: "//*[@id='order__header__currencies']/select")
    element(:avangate_currency_selected, xpath: "//*[@id='order__header__currencies']//option[@selected]")

    # billing info fields
    text_field(:full_name, xpath: '//*[@id="fullname"]')
    text_field(:email, xpath: '//*[@id="email"]')
    select_list(:billing_country, xpath: '//*[@id="billingcountry"]')

    # payment options
    text_field(:card_number, xpath: '//*[@id="tiCNumber"]')
    text_field(:cvv, xpath: '//*[@id="tiCVV"]')
    select_list(:exp_month, xpath: '//*[@id="cbExpMounth"]')
    select_list(:exp_year, xpath: '//*[@id="cbExpYear"]')
    text_field(:name_on_card, xpath: '//*[@id="nameoncard"]')

    # REVIEW: and checkout
    link(:review_and_checkot, xpath: '')

    text_field(:avangate_fname, xpath: "//*[@id='fname']")
    text_field(:avangate_lname, xpath: "//*[@id='lname']")
    text_field(:avangate_address, xpath: "//*[@id='address']")
    text_field(:avangate_city, xpath: "//*[@id='city']")
    text_field(:avangate_zipcode, xpath: "//*[@id='zipcode']")
    select_list(:avangate_country, xpath: '//*[@id="billingcountry"]')
    text_field(:avangate_email, xpath: "//*[@id='email']")
    text_field(:avangate_re_email, xpath: "//*[@id='re_email']")
    text_field(:avangate_tiCNumber, xpath: "//*[@id='tiCNumber']")
    text_field(:avangate_tiCVV, xpath: "//*[@id='tiCVV']")
    text_field(:avangate_nameoncard, xpath: "//*[@id='nameoncard']")

    select_list(:avangate_cbExpMounth, xpath: "//select[@id='cbExpMounth']")
    select_list(:avangate_cbExpYear, xpath: "//select[@id='cbExpYear']")

    element(:avangate_logo_link, xpath: '//*[@id="avs_header"]/*[@id="logo"]')
    element(:avangate_with_vat_price, xpath: "//*[@id='with_vat_val']")
    element(:avangate_with_without_vat, xpath: "//*[@id='td_price']/div[2]")
    element(:avangate_main_continue_button, xpath: '//input[@id="checkoutSubmitBtn"]')
    element(:avangate_user_storage_link, xpath: '//*[@id="order__products"]//td[contains(@class,"item__name")]')
    element(:avangate_total_price, xpath: '//div[contains(@class,"order__total")]')
    element(:avangate_price_without_vat, xpath: '//*[@id="without_vat_val"]')
    element(:avangate_total_value_price, xpath: '//*[contains(@class,"order__listing__item__total__price")]')
    element(:avangate_upsell_frame, xpath: '//*[@id="order__page__upsell_product"]')
    element(:avangate_upsell_close, xpath: '//*[@id="order__page__upsell_product"]//a')

    def initialize(instance, select_usd = true, close_upsell = false)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load(select_usd, close_upsell)
    end

    def wait_to_load(select_usd = true, close_upsell = false)
      @instance.webdriver.wait_until do
        avangate_logo_visible? ||
          avangate_upsell_frame_visible? ||
          avangate_user_storage_visible? ||
          avangate_main_continue_button_visible?
      end
      if close_upsell
        avangate_upsell_close_element.click if avangate_upsell_frame_visible?
      end
      select_avangate_usd_price if select_usd
    end

    def avangate_upsell_frame_visible?
      avangate_upsell_frame_element.present?
    end

    def submit_avangate_main_order(portal, price = 'price')
      self.avangate_fname = PaymentData::TO
      self.avangate_lname = price
      self.avangate_address = PaymentData::OTHER
      self.avangate_city = PaymentData::OTHER
      self.avangate_zipcode = PaymentData::OTHER
      avangate_country_element.select_value(PaymentData::HOLDER_COUNTRY_CODE)
      sleep 1
      wait_to_load
      self.avangate_email = SettingsData::EMAIL
      self.avangate_re_email = SettingsData::EMAIL
      self.avangate_tiCNumber = PaymentData::CARD_NUMBER
      @instance.webdriver.select_combo_box(avangate_cbExpMounth_xpath, PaymentData::MONTH)
      @instance.webdriver.select_combo_box(avangate_cbExpYear_xpath, PaymentData::YEAR)
      self.avangate_tiCVV = PaymentData::CVV2
      self.avangate_nameoncard = PaymentData::HOLDER_NAME
      avangate_main_continue_button_element.click
      AvangateFinishOrder.new(@instance)
      @instance.webdriver.open(portal)
      MainPage.new(@instance)
    end

    def submit_avangate_order_new
      fill_test_payment_data
      avangate_continue
      AvangateFinishOrder.new(@instance)
      @instance.webdriver.open(@instance.user.portal)
      MainPage.new(@instance)
    end

    def submit_avangate_order_for_notification(params = {})
      fill_test_payment_data_for_notify(params)
      AvangateFinishOrder.new(@instance)
    end

    def fill_test_payment_data_for_notify(params = {})
      self.avangate_fname = Faker::Name.first_name
      self.avangate_lname = Faker::Name.last_name
      self.avangate_address = PaymentData::OTHER
      self.avangate_city = PaymentData::OTHER
      self.avangate_zipcode = PaymentData::OTHER
      avangate_country_element.select_value(PaymentData::HOLDER_COUNTRY_CODE)
      sleep 1
      wait_to_load
      self.avangate_email = params[:email]
      self.avangate_re_email = params[:email]
      self.avangate_tiCNumber = PaymentData::CARD_NUMBER
      self.avangate_cbExpMounth = PaymentData::MONTH
      self.avangate_cbExpYear = PaymentData::YEAR
      self.avangate_tiCVV = PaymentData::CVV2
      self.avangate_nameoncard = PaymentData::HOLDER_NAME
      avangate_main_continue_button_element.click
    end

    def avangate_continue
      avangate_main_continue_button_element.click
    rescue Selenium::WebDriver::Error::UnhandledAlertError
      @instance.webdriver.webdriver_error('avangate captcha!')
    end

    def fill_test_payment_data
      exp_month_element.select_value PaymentData::MONTH
      exp_year_element.select_value PaymentData::YEAR
      billing_country_element.select_value PaymentData::HOLDER_COUNTRY_CODE
      self.full_name = Faker::Name.name
      self.email = SettingsData::EMAIL
      self.card_number = PaymentData::CARD_NUMBER
      self.cvv = PaymentData::CVV2
      self.name_on_card = PaymentData::HOLDER_NAME
    end

    def avangate_main_continue_button_visible?
      avangate_main_continue_button_element.present?
    end

    def avangate_logo_visible?
      avangate_logo_link_element.present?
    end

    def avangate_user_storage_visible?
      avangate_user_storage_link_element.present?
    end

    def select_avangate_usd_price
      return if currency_selected == 'USD'

      @instance.webdriver.select_combo_box(avangate_price_select_xpath, 'USD')
      sleep 1
      @instance.webdriver.wait_until do
        currency_selected == 'USD'
      end
    end

    def get_avangate_current_price
      @instance.webdriver.get_element(avangate_total_value_price_xpath).attribute('innerHTML').split.last
    end

    def get_avangate_current_price_value
      # values = @instance.webdriver.get_element(avangate_total_value_price_xpath).attribute("innerHTML").split
      values = [avangate_total_value_price_element.text]
      value = values.detect { |val| val.match(/(\d+(?:,|.))?\d+(.\d+)?/) }.to_s.sub(',', '')
      value = value[1..-1] if value[0].to_i.zero?
      value
    end

    def currency_selected
      avangate_currency_selected_element.attribute('value')
      # @instance.webdriver.get_attribute(avangate_currency_selected_xpath, 'value')
    end

    def get_avangate_current_users
      get_product_name[/\d\d?-\d\d?/]
    end

    def get_product_name
      @instance.webdriver.get_text(avangate_user_storage_link_element)
    end
  end
end
