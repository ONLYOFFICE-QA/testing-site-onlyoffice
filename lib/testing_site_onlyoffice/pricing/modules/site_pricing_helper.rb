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
    span(:total_price, xpath: '//div[@data-id = "ie-pp-sum"]//span[@class="pp_price_number"]')
    div(:home_tariff, xpath: '//div[@data-id="ee-home"]')
    div(:business_tariff, xpath: '//div[@data-id="ee-business"]')
    div(:num_connections, xpath: '//div[@class="num-connections"]//div[@data-id="ie-number-updated"]')
    div(:add_num_connections, xpath: '//div[@class="num-connections"]//div[@class="pp_connections_increase simcon_change"]')
    link(:buy_now_button, xpath: "//a[@data-id = 'ie-price-url-updated']")
    link(:buy_home_server, xpath: '//a[@id = "hrefHomeServer"]')
    span(:home_use_price, xpath: '//div[contains(@class, "ee-home")]//span[@class = "pp_price_number"]')

    # Get a quote form
    text_field(:full_name, xpath: '//input[@id = "txtFirstName"]')
    text_field(:email, xpath: '//input[@id = "txtEmail"]')
    text_field(:phone_number, xpath: '//input[@id = "txtPhone"]')
    text_field(:company_name, xpath: '//input[@id = "txtCompanyName"]')
    button(:submit_button, xpath: '//input[@id = "sbmtRequest"]')
    span(:support_multi_server, xpath: '//input[@id = "multi-server-deployment"]/following-sibling::span')
    span(:training_courses, xpath: '//input[@id = "training-courses"]/following-sibling::span')

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

    def button_get_quote_present?
      @instance.webdriver.element_present?(total_price_get_a_quote_element)
    end

    def press_button_get_quote
      @instance.webdriver.wait_until { button_get_quote_present? }
      total_price_get_a_quote_element.click
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

    def fill_data_pricing_page(number_connection, support_level, support_multi: false, training_course: false)
      choose_number_connection(number_connection)
      choose_support_level(support_level)
      support_multi_server_element.click if support_multi
      training_courses_element.click if training_course
    end

    # Press 'Get a Quote' button to open up a form
    # Fill out the form and press 'Submit request' button
    # @param [Hash] user_data - data for form, default values are used if hash is empty
    def complete_pricing_page_form(user_data = {})
      press_button_get_quote
      self.full_name = user_data.fetch(:full_name, TestingSiteOnlyoffice::SiteData::DEFAULT_ADMIN_FULLNAME)
      self.email = user_data.fetch(:email, TestingSiteOnlyoffice::SiteData::EMAIL_ADMIN)
      self.phone_number = user_data[:phone_number]
      self.company_name = user_data[:company_name]
      press_button_submit
    end

    # Press 'Submit request' button
    # !Important note!: Method does not wait for a button to become available and press it on a disabled status
    # This behaviour was explained by Tiulneva Irina as follows:
    # Button with status 'disabled' does not actually deny the fields to be processed, so processing mechanism
    # will proceed and since all fields are fulfilled, the status of a button is immediately changed to 'enabled' before click on it happens.
    def press_button_submit
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(submit_button_element) }
      @instance.webdriver.click_on_locator(submit_button_element)
    end
  end
end
