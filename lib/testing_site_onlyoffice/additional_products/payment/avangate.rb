# frozen_string_literal: true

require_relative 'data/payment_data'
require_relative 'avangate_finish_order'

module TestingSiteOnlyoffice
  # https://store.onlyoffice.com/order/checkout.php
  # https://user-images.githubusercontent.com/40513035/120980303-56e06600-c72b-11eb-9752-630afdeb2609.png
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
    element(:avangate_main_continue_button, xpath: '//input[@id="checkoutSubmitBtn"]')
    element(:avangate_user_storage_link, xpath: '//*[@id="order__products"]//td[contains(@class,"item__name")]')
    element(:avangate_current_value_price, xpath: '//*[contains(@class,"order__listing__item__total__price")]')
    element(:avangate_upsell_frame, xpath: '//*[@id="order__page__upsell_product"]')
    element(:avangate_upsell_close, xpath: '//*[@id="order__page__upsell_product"]//a')
    element(:avangate_total_value_price, xpath: '//div[@class="products-total-row products-total order__total products-content__total"]//*[contains(@class,"order__billing__total clearfix")]')
    element(:avangate_total_tax_value_price, xpath: '//div[@class="products-total-row products-totalvat order__sub__total products-content__totalvat"]//*[contains(@class,"order__billing__total clearfix")]')

    def initialize(instance, params = {})
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load(params)
    end

    def wait_to_load(params = {})
      select_usd = params.fetch(:select_usd, true)
      close_upsell = params.fetch(:close_upsell, false)
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
      @instance.webdriver.element_present?(avangate_upsell_frame_element)
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
      avangate_country_element.select(PaymentData::HOLDER_COUNTRY_CODE)
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

    def avangate_main_continue_button_visible?
      @instance.webdriver.element_present?(avangate_main_continue_button_element)
    end

    def avangate_logo_visible?
      @instance.webdriver.element_present?(avangate_logo_link_element)
    end

    def avangate_user_storage_visible?
      @instance.webdriver.element_present?(avangate_user_storage_link_element)
    end

    def select_avangate_usd_price
      return if currency_selected == 'USD'

      @instance.webdriver.select_combo_box(avangate_price_select_xpath, 'USD')
      sleep 1
      @instance.webdriver.wait_until do
        currency_selected == 'USD'
      end
    end

    def parse_price(values)
      value = values.detect { |val| val.match(/(\d+(?:,|.))?\d+(.\d+)?/) }.to_s.sub(',', '')
      value = value[1..-1] if value[0].to_i.zero?
      value.to_i
    end

    def current_price
      parse_price([avangate_current_value_price_element.text])
    end

    def total_price
      parse_price([avangate_total_value_price_element.text])
    end

    def total_tax
      parse_price([avangate_total_tax_value_price_element.text])
    end

    def total_amount_without_tax
      total_price - total_tax
    end

    def currency_selected
      avangate_currency_selected_element.attribute('value')
    end
  end
end
