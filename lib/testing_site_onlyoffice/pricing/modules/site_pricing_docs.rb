# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Methods for changing purchase parameters
  module SitePriceDocs
    include PageObject

    div(:support_basic, xpath: '//div[@class = "ee-calculator-part"]//div[@data-id="basic_support"]')
    div(:support_plus, xpath: '//div[@class = "ee-calculator-part"]//div[@data-id="plus_support"]')
    div(:support_premium, xpath: '//div[@class = "ee-calculator-part"]//div[@data-id="premium_support"]')
    div(:total_price_upon_request, xpath: '//div[@class="total-price-amount"]//div[@data-id="ie-pp-sum-req"]')
    span(:total_price, xpath: '//div[@class="total-price-amount"]//span[@class="pp_price_number"]')

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

    def total_price_upon_request
      @instance.webdriver.wait_until do
        total_price_upon_request_element.attribute('class').include?('pp_sum req')
      end
      @instance.webdriver.get_text(total_price_upon_request_element)
    end

    def total_price_number
      @instance.webdriver.get_text(total_price_element)
    end
  end
end
