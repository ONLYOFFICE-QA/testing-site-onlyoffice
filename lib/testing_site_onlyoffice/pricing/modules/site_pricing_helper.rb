# frozen_string_literal: true

require_relative '../../additional_products/payment/avangate'
require_relative '../../additional_products/payment/stripe_payment_page'

module TestingSiteOnlyoffice
  # Helper methods for pricing pages
  module SitePricingHelper
    include PageObject

    div(:support_basic, xpath: "//div[@data-id='basic_support']")
    div(:support_plus, xpath: "//div[@data-id='plus_support']")
    div(:support_premium, xpath: "//div[@data-id='premium_support']")
    div(:total_price_upon_request, xpath: "//div[@data-id='ie-pp-sum-req']")
    link(:total_price_get_a_quote, xpath: "//a[@data-id='ie-gaq']")
    span(:total_price, xpath: "//div[@data-id = 'ie-pp-sum']//span[@class='pp_price_number']")
    div(:home_tariff, xpath: '//div[@data-id="ee-home"]')
    div(:business_tariff, xpath: '//div[@data-id="ee-business"]')
    div(:num_connections, xpath: '//div[@class="num-connections"]//div[@data-id="ie-number-updated"]')
    div(:add_num_connections, xpath: '//div[@class="num-connections"]//div[@class="pp_connections_increase simcon_change"]')
    link(:buy_now_button, xpath: "//a[@data-id = 'ie-price-url-updated']")
    link(:buy_home_server, xpath: '//a[@id = "hrefHomeServer"]')
    span(:home_use_price, xpath: '//div[contains(@class, "ee-home")]//span[@class = "pp_price_number"]')

    def go_to_payment_from_pricing_page(buy_element, test_purchase: false)
      workaround_webdriver_hangs_on_timeout(buy_element)
      wait_pricing_on_production
      if test_purchase
        return StripePaymentPage.new(@instance) if @instance.webdriver.current_url.include?('stripe.com')

        Avangate.new(@instance)
        @instance.webdriver.open("#{@instance.webdriver.current_url}&DOTEST=1")
      end
      Avangate.new(@instance)
    end

    # For some reason loading stripe page on production server
    # require several redirects and them not very fast, so we need to wait
    # @return [nil]
    def wait_pricing_on_production
      return unless config.server.include?('.com')

      sleep 5
    end

    # Workaround method for redirects
    # @param [PageObject] buy_element is a PageObject element representing in this case
    #   button that is pressed on the web page
    # @return [nil]
    def workaround_webdriver_hangs_on_timeout(buy_element)
      url = @instance.webdriver.get_attribute(buy_element, 'href')
      @instance.webdriver.open(url)
    end

    def choose_support_level(support_level)
      choose_support_basic if support_level == 'Basic'
      choose_support_plus if support_level == 'Plus'
      choose_support_premium if support_level == 'Premium'
    end

    def choose_support_basic
      support_basic_element.click
      @instance.webdriver.wait_until do
        support_basic_element.attribute('class').include?('selected_sp')
      end
    end

    def choose_support_plus
      support_plus_element.click
      @instance.webdriver.wait_until do
        support_plus_element.attribute('class').include?('selected_sp')
      end
    end

    def choose_support_premium
      support_premium_element.click
      @instance.webdriver.wait_until do
        support_premium_element.attribute('class').include?('selected_sp')
      end
    end

    def total_price_number
      @instance.webdriver.get_text(total_price_element)
    end

    def total_price_home_use
      @instance.webdriver.get_text(home_use_price_element)
    end

    def total_price_upon_request
      @instance.webdriver.wait_until do
        total_price_upon_request_element.attribute('class').include?('pp_sum req')
      end
      @instance.webdriver.get_text(total_price_upon_request_element)
    end

    def choose_home_tariff
      home_tariff_element.click
    end

    def choose_number_connection(connection)
      add_num_connections_element.click while num_connection != connection
    end

    def num_connection
      @instance.webdriver.get_text(num_connections_element)
    end

    def fill_data_pricing_page(number_connection, support_level)
      choose_number_connection(number_connection)
      choose_support_level(support_level)
    end
  end
end
