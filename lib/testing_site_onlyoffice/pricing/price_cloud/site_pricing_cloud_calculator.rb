# Cloud services price calculator
# https://user-images.githubusercontent.com/40513035/115660902-82c99880-a2f1-11eb-92d6-c8e6b88fee93.png

module TestingSiteOnlyoffice
  module SitePricingCloudCalculator
    include PageObject

    # switch period
    div(:month, xpath: "(//div[@data-id='saas-month'])[2]")
    div(:one_year, xpath: "(//div[@data-id='saas-year-1'])[2]")
    div(:three_years, xpath: "(//div[@data-id='saas-year-3'])[2]")

    # user selector
    div(:user_number, xpath: "//div[@class='inner-text combobox-title-inner-text']")
    text_field(:input_user_number, xpath: "//input[@class='saas-input-bsn']")

    div(:total_price, xpath: "//div[@class='saas-total-price-value']")

    div(:buy_now_calculator, xpath: "//div[contains(@class, 'saas-popup-btns')]/div[@class= 'saas-buy-now-box']")
    link(:contact_us_calculator, xpath: "//div[contains(@class, 'saas-popup')]//a[@class='saas-bsn-contact-us button gray']")

    def current_tariff_price
      total_price_element.text
    end

    def users_number_dropdown_xpath(user_number)
      "//ul[@class='combobox-options']/li[@title='#{user_number}']"
    end

    def current_user_number
      user_number_element.text
    end

    def open_user_number_dropdown
      user_number_element.click
      @instance.webdriver.wait_until { @instance.webdriver.driver.find_element(:xpath, users_number_dropdown_xpath(5)).present? }
    end

    def chooser_users_number_from_dropdown(user_number)
      open_user_number_dropdown
      @instance.webdriver.driver.find_element(:xpath, users_number_dropdown_xpath(user_number)).click
      @instance.webdriver.wait_until { current_user_number == user_number }
    end

    def input_user_number(user_number)
      open_user_number_dropdown
      self.input_user_number = user_number
      @instance.webdriver.press_key(:enter)
    end

    def buy_now
      buy_now_calculator_element.click
      Avangate.new(@instance)
    end
  end
end
