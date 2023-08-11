# frozen_string_literal: true

require_relative '../../additional_products/site_faq'
require_relative '../../additional_products/payment/avangate'
require_relative '../../get_onlyoffice/site_get_onlyoffice_sign_up'
require_relative 'site_pricing_cloud_calculator'
require_relative 'site_require_vip_cloud'
require_relative '../../additional_products/personal_main_page'
require_relative '../modules/site_pricing_workspace_toolbar'

module TestingSiteOnlyoffice
  # /docspace-prices.aspx#docspace-cloud
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/13a3aa4f-d48a-4e2a-a410-b10dd20c4316
  class SitePricingCloud
    include PageObject
    include SitePricingCloudCalculator
    include SiteToolbar
    include SitePricingWorkspaceToolbar

    # startup
    startup = "//div[contains(@class, 'saas-cell-startup')]"
    link(:startup_start_now, xpath: "#{startup}//a[@class='button gray']")
    span(:startup_price_person, xpath: "#{startup}//span[contains(@class, 'price-value')]")

    # business
    link(:business_try_it_for_free, xpath: "//a[@href = '/download-workspace.aspx?from=workspace-enterprise-prices']")
    link(:business_calculate_your_price, xpath: "//a[contains(@class, 'saas-calculate')]")

    # vip
    link(:vip_submit_request, xpath: "//a[@href='/order.aspx']")

    # faq
    list_item(:other_questions, xpath: "(//div[@class='faq_pricing_block']/ul/li)[3]")
    link(:faq_linq, xpath: "//a[contains(@href, 'faq.aspx')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(business_try_it_for_free_element) }
    end

    def cost_tariff_business_3_year
      business_calculate_your_price_element.click
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(total_price_element) }
      current_tariff_price
    end

    def click_on_faq_center
      other_questions_element.click
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(faq_linq_element) }
      faq_linq_element.click
      SiteFaq.new(@instance)
    end

    def vip_submit_request
      vip_submit_request_element.click
      SiteRequireVIPCloud.new(@instance)
    end

    def startup_start_now
      startup_start_now_element.click
      SiteDocSpaceRegistration.new(@instance)
    end

    def business_try_it_for_free
      business_try_it_for_free_element.click
      SiteGetOnlyofficeSignUp.new(@instance)
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
        cloud_period_price_identification = @instance.webdriver.driver.find_elements(:xpath, cloud_period_price_identification_xpath(period))[0]
        @instance.webdriver.element_present?(cloud_period_price_identification)
      end
    end

    def personal_contact_us_works?
      personal_contact_us_page = personal_contact_us
      personal_contact_us_page.is_a? PersonalMainPage
    end

    def calculate_your_price
      business_calculate_your_price_element.click
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(buy_now_calculator_element) }
    end
  end
end
