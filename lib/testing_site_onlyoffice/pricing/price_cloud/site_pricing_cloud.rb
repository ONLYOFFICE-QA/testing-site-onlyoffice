# frozen_string_literal: true

require_relative '../../additional_products/site_faq'
require_relative '../../additional_products/payment/avangate'
require_relative '../../get_onlyoffice/site_sign_up'
require_relative 'site_pricing_cloud_calculator'
require_relative 'site_require_vip_cloud'

module TestingSiteOnlyoffice
  # /saas.aspx
  # https://user-images.githubusercontent.com/40513035/115361865-d911cc80-a175-11eb-88da-868922b05024.png
  class SitePricingCloud
    include PageObject
    include SitePricingCloudCalculator
    include SiteToolbar

    # startup
    startup = "//div[contains(@class, 'saas-cell-startup')]"
    link(:startup_start_now, xpath: "#{startup}//a[@class='button red']")
    span(:startup_price_person, xpath: "#{startup}//span[contains(@class, 'price-value')]")

    # business
    link(:business_try_it_for_free, xpath: "//a[@class='saas-try-free']")
    link(:business_calculate_your_price, xpath: "//a[contains(@class, 'saas-calculate')]")

    # vip
    link(:vip_contact_us_top, xpath: "//div[contains(@class, 'saas-cell-vip')]//a[contains(@class, 'saas-vip-contact-us')]")

    # faq
    list_item(:other_questions, xpath: "(//div[@class='faq_pricing_block']/ul/li)[3]")
    link(:faq_linq, xpath: "//a[contains(@href, 'faq.aspx')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { business_try_it_for_free_element.present? }
    end

    def cost_tariff_business_3_year
      business_calculate_your_price_element.click
      @instance.webdriver.wait_until { total_price_element.present? }
      current_tariff_price
    end

    def click_on_faq_center
      other_questions_element.click
      @instance.webdriver.wait_until { faq_linq_element.present? }
      faq_linq_element.click
      SiteFaq.new(@instance)
    end

    def vip_contact_us
      vip_contact_us_top_element.click
      SiteRequireVIPCloud.new(@instance)
    end

    def startup_start_now
      startup_start_now_element.click
      SiteSignUp.new(@instance)
    end

    def business_try_it_for_free
      business_try_it_for_free_element.click
      SiteSignUp.new(@instance)
    end

    def current_price_period
      element = [month_element, one_year_element, three_years_element].each do |period_element|
        break period_element if period_element.attribute('class').include?('active')
      end
      @instance.webdriver.webdriver_error('No period element is selected') unless element
      element.attribute('data-id').delete_prefix('saas-').to_sym
    end

    def cloud_period_price_identification_xpath(period)
      "(//div[@class='saas-price-users-btn saas-#{period}'])[1]"
    end

    def cloud_period_price_xpath(period)
      "(//div[@data-id='saas-#{period}'])[1]"
    end

    def change_period(period)
      return if current_price_period == period

      @instance.webdriver.driver.find_elements(:xpath, cloud_period_price_xpath(period))[0].click
      @instance.webdriver.wait_until do
        @instance.webdriver.driver.find_elements(:xpath, cloud_period_price_identification_xpath(period))[0].present?
      end
    end

    def vip_contact_us_works?
      if current_price_period == :month
        vip_contact_us_top_element.attribute('class').include?('disabled')
      else
        vip_contact_us_page = vip_contact_us
        vip_contact_us_page.is_a? SiteRequireVIPCloud
      end
    end

    def calculate_your_price
      business_calculate_your_price_element.click
      @instance.webdriver.wait_until { buy_now_calculator_element.present? }
    end
  end
end
