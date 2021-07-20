# frozen_string_literal: true

require_relative '../../../pricing/modules/site_pricing_helper'
require_relative '../../../pricing/site_pricing_docs_enterprise'

module TestingSiteOnlyoffice
  # /support.aspx
  # https://user-images.githubusercontent.com/40513035/126144130-9be03fe2-f125-450b-aeb6-36a3fabd2e07.png
  class SitePremiumSupport
    include PageObject
    include SitePricingHelper

    link(:buy_now_support, xpath: '//a[@class="button red standartBuyButton"]')
    link(:choose_your_plan, xpath: '//a[contains(@class, "basicBuyButton")]')

    # Plus
    link(:plus_get_a_quote, xpath: "//a[@class='button gray standartBuyButton']")
    div(:plus_user_number, xpath: "//div[@id='standart-users-value']")
    div(:increase_plus_users, xpath: "//div[contains(@class, 'standartSelectors') and @data-direction='right']")
    div(:decrease_plus_users, xpath: "//div[contains(@class, 'standartSelectors') and @data-direction='left']")

    # Premium
    link(:premium_get_a_quote, xpath: "//a[@class='button gray premiumBuyButton']")
    div(:premium_user_number, xpath: "//div[@id='premium-users-value']")
    div(:increase_premium_users, xpath: "//div[contains(@class, 'premiumSelectors') and @data-direction='right']")
    div(:decrease_premium_users, xpath: "//div[contains(@class, 'premiumSelectors') and @data-direction='left']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        buy_now_support_element.present?
      end
    end

    def increase_plus_users
      increase_plus_users_element.click
    end

    def decrease_plus_users
      decrease_plus_users_element.click
    end

    def increase_premium_users
      increase_premium_users_element.click
    end

    def decrease_premium_users
      decrease_premium_users_element.click
    end

    def choose_your_plan
      choose_your_plan_element.click
      SitePriceDocsEnterprise.new(@instance)
    end

    def current_support_plus_price_and_user_number
      user_number = plus_user_number_element.text
      price_xpath = "//div[@data-value='#{user_number}' and @class='pp_sum standartSum']/span"
      price = @instance.webdriver.driver.find_element(:xpath, price_xpath).text
      { price: price.to_i, user_number: user_number.to_i }
    end

    def current_support_premium_price_and_user_number
      user_number = premium_user_number_element.text
      price_xpath = "//div[@data-value='#{user_number}' and @class='pp_sum premiumSum']/span"
      price = @instance.webdriver.driver.find_element(:xpath, price_xpath).text
      { price: price.to_i, user_number: user_number.to_i }
    end

    def plus_quote_email
      @instance.webdriver.get_attribute(plus_get_a_quote_element, 'href')
    end

    def premium_quote_email
      @instance.webdriver.get_attribute(premium_get_a_quote_element, 'href')
    end
  end
end
