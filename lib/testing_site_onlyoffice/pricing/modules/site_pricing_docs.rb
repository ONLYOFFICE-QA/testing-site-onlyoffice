# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Methods for changing purchase parameters
  module SitePriceDocs
    include PageObject

    BASE_XPATH = '//div[contains(@class, "ee-business") or contains(@class, "ee-production")]'
    div(:support_basic, xpath: "#{BASE_XPATH}//div[@data-id='basic_support']")
    div(:support_plus, xpath: "#{BASE_XPATH}//div[@data-id='plus_support']")
    div(:support_premium, xpath: "#{BASE_XPATH}//div[@data-id='premium_support']")
    link(:total_price_upon_request, xpath: "#{BASE_XPATH}//a[@data-id='ie-gaq']")
    span(:total_price, xpath: "#{BASE_XPATH}//div[@class='pp_sum']//span[@class='pp_price_number']")

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
  end
end
